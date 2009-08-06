Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: losing HCI connection over USB
Date: Thu, 6 Aug 2009 00:32:42 -0700
Message-ID: <236BF8CF9C36804E939BC8FEB21AEA1D175988@pdxemail.kittelson.com>
From: "Ian Cameron" <icameron@kittelson.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This happens with btusb or hci_usb module. I am using a USB dongle on an extender cable (about 3m long) and have tried on several different computers.  When I start using hcidump –V (lots of traffic) I start having radios drop out, but sometimes they drop with just hcitool commands.  lsusb lists the Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode) but hcitool dev does not list the device after it loses connection and hciconfig hci0 up gives errors such as Can’t init device hci0: Function not implemented (38).  If I try a hcitool command I get Invalid device: Network is down.  Dmesg has some errors, I think the relevant ones are:

hub 4-0:1.0: port 1 disabled by hub (EMI?), re-enabling
btusb_intr_complete: hci0 urb f539e700 failed to resubmit (19)
btusb_intr_complete: hci0 corrupted event packet

It only happens on USB extension cables... they are new USB 2.0 cables and only 10 feet long so I wonder what is going on or who to ask for help.  Does Bluez handle possible errors with sending commands and receiving events over a USB extension cable that may introduce some data loss, latency(?) or corruption between the host and controller?  It seems to drop out when there is a corrupted event packet.  Thank you for your time.
-Ian
