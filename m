Return-Path: <cyrus@holtmann.org>
Subject: Re: losing HCI connection over USB
From: Marcel Holtmann <marcel@holtmann.org>
To: Ian Cameron <icameron@kittelson.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <236BF8CF9C36804E939BC8FEB21AEA1D175988@pdxemail.kittelson.com>
References: <236BF8CF9C36804E939BC8FEB21AEA1D175988@pdxemail.kittelson.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Aug 2009 13:13:04 -0700
Message-Id: <1249589584.21101.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> This happens with btusb or hci_usb module. I am using a USB dongle on an extender cable (about 3m long) and have tried on several different computers.  When I start using hcidump –V (lots of traffic) I start having radios drop out, but sometimes they drop with just hcitool commands.  lsusb lists the Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode) but hcitool dev does not list the device after it loses connection and hciconfig hci0 up gives errors such as Can’t init device hci0: Function not implemented (38).  If I try a hcitool command I get Invalid device: Network is down.  Dmesg has some errors, I think the relevant ones are:
> 
> hub 4-0:1.0: port 1 disabled by hub (EMI?), re-enabling
> btusb_intr_complete: hci0 urb f539e700 failed to resubmit (19)
> btusb_intr_complete: hci0 corrupted event packet
> 
> It only happens on USB extension cables... they are new USB 2.0 cables and only 10 feet long so I wonder what is going on or who to ask for help.  Does Bluez handle possible errors with sending commands and receiving events over a USB extension cable that may introduce some data loss, latency(?) or corruption between the host and controller?  It seems to drop out when there is a corrupted event packet.  Thank you for your time.

this question might be better asked on the USB mailing list. It is not a
real Bluetooth problem.

Regards

Marcel


