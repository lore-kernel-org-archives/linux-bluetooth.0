Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: BT led trigger
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3891fa14-043d-abf8-786c-1a2a82925283@monstr.eu>
Date: Wed, 31 May 2017 20:11:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8963E8AB-C6B0-4081-B8B5-CDF1CE4A0A2E@holtmann.org>
References: <0d6dd864-4c1b-5b78-ad67-98343ee42950@monstr.eu>
 <224A641D-142D-4C11-BA6A-8AE1D338752D@holtmann.org>
 <3891fa14-043d-abf8-786c-1a2a82925283@monstr.eu>
To: monstr@monstr.eu
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

>>> I have found your name in connection to net/bluetooth/leds.c trigger.
>>> I understand that this trigger will show status of hci controller
>>> and this is just working fine. I have tested it without any issue.
>>> I am curious if we could use this trigger to handle also gpio signal
>>> which is enabling BT. I am using ti chip where we have bt_en connected
>>> to gpio.
>>> I have seen that people are handling this from userspace by exporting
>>> gpio and writing values there but it looks pretty bad to me.
>>> 
>>> Have you ever tried to use bt led trigger also for handling gpio enable
>>> signals? Or is there any other nice way how to handle it?
>> 
>> that is the wrong approach. See how hci_intel.c, hci_bcm.c, hci_nokia.c and others are dealing with the GPIO pins in the background. There is no need for any user space hacks anymore.
> 
> I use TI wl1831 over uart with flow control which is using hci_ll.c.
> I understand handling when you have specific driver that you need to
> handle it. But if this is just over uart where from simply running
> "hciattach -n /dev/ttyS1 texas"
> I can detect this chip.

that one just got integrated with the serdev serial device bus and can be configured via DT.

Regards

Marcel

