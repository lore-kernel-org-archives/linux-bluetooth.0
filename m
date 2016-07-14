Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Disappointing BLE throughput scheme/results
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 14 Jul 2016 12:37:40 -0700
Message-Id: <812914A8-66C2-4343-8A1B-FB6EC1905DFE@gmail.com>
References: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’m working on an app that uses bluez on an embedded linux SBC, acting as a peripheral. I connect to it with an iOS central app for the purpose of configuration/query. I have to do some limited “streaming” of arbitrary byte lengths between the two to pull this off. So based on some of the feedback I received here, stack overflow, and some experimentation, I came up with a scheme for doing so (described briefly below). I’ve used this same scheme between a different iOS app and an embedded stmicro bluenrg chip, where I’m able to push 26KB firmware upgrades in 9.5 seconds. Unfortunately, I’m getting nowhere this kind of performance between my iOS app and my little linux device.

The basic scheme involves using a control characteristic with verified writes/indications, and then a separate characteristic without verifications (e.g. write-without-response and notify) to send the actual data. This was based on the understanding that these unverified transactions can happen very fast and basically be buffered by the hardware/stack. I found through experimentation that iOS seems to have enough buffers for almost 32 writes before the data seems to disappear into the ether. So I use a scheme of bursts of 16.

To be bidirectional, I have the following 3 characteristics set up

Control (“write”, “indicate”)
Request(“write-without-response”)
Response(“notify”)

As an example then, the central wants to make a 49 byte request, that will result in a 63 byte response. It would go down something like (in pseudo code-ish terms):

iOS.Control.WriteValue(RequestSize: 49)
bluez.Control.WriteValue()
    notes that 49 bytes are coming
bluez.Control.ValueChanged(ReceivedRequest: 0)
iOS.Control.ValueChanged()
   notes that 0 have been received so far, initiates a burst of up to 16 writes
ios.Request.WriteValue(request[0:20])
ios.Request.WriteValue(request[20:40])
ios.Request.WriteValue(request[40:49])
bluez.Request.WriteValue()
    appends first 20 bytes
bluez.Request.WriteValue()
    appends second 20 bytes
bluez.Request.WriteValue()
    appends last 9 bytes, notes that expected byte count has now been received and processes the request. derives the 63 byte response
bluez.Control.ValueChanged(ResponseSize: 63)
ios.Control.ValueChanged()
    notes that 63 bytes are coming
iOS.Control.WriteValue(ReceivedResponse: 0)
bluez.Control.WriteValue()
    notes that 0 have been received so far, initiates a burst of up to 16 writes
bluez.Response.ValueChanged(response[0:20])
bluez.Response.ValueChanged(response[20:40])
bluez.Response.ValueChanged(response[40:60])
bluez.Response.ValueChanged(response[60:63])
ios.Response.ValueChanged()
    appends first 20 bytes
ios.Response.ValueChanged()
    appends second 20 bytes
ios.Response.ValueChanged()
    appends third 20 bytes
ios.Response.ValueChanged()
    appends last 3 bytes, notes that the expected byte count has now been received and does its thing with the response


I’ve been disappointed with this. I am using a python program on the bluez side, running on a 351 bogomip ARM7. I know there’s some overhead involved in the various layers as data makes its way from my blue tooth dongle through the kernel, bluetoothd, and over dbus to my python program. Placing some timing statements in the flow hasn’t been entirely conclusive, but one area that seems to be pretty regular, is that hand off where one side says “I want to send you X bytes” and then waits to hear back from the other side hearing the initial “so far I’ve got 0 bytes” which is the sending sides queue to burst up to 16 writes. That often takes ~110 ms. I’m not sure why that’s taking so long. I’m not sure if it’s split evenly between the write and the indicate, or if one is dominating. Any insights/suggestions/hints anyone has on this would be much appreciated.