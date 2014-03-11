Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: rctest -c "Can't connect: Device or resource busy (16)"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yC=+XNxEx5ivA+ebGi_Cjui2Mcrx+q83b-eUPvt2J0XLPw@mail.gmail.com>
Date: Tue, 11 Mar 2014 16:03:56 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <7C822ED2-E0F6-4CC7-AF1D-D909AD7C0B1F@holtmann.org>
References: <CAHZ1yC=+XNxEx5ivA+ebGi_Cjui2Mcrx+q83b-eUPvt2J0XLPw@mail.gmail.com>
To: Scott James Remnant <keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

> Is this expected behavior for RFCOMM? When using rctest -r on one
> side, and rctest -c (connect/disconnect/connect...) on the other, the
> client side fails to connect a significant percentage of the time:
> 
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Connected [handle 34817, class 0xff8801, priority 0]
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)
> rctest[23705]: Can't connect: Device or resource busy (16)

it is not an expected behavior. Can you create a btmon trace for this and see what error code we get on the HCI level.

Without any kind of analysis this sound like a race condition in the disconnect handling where the connection is not fully terminated and you try to re-connect too quickly.

What kernel version is this? And as usual the first question, do you still see this behavior with a bluetooth-next kernel?

Regards

Marcel

