Return-Path: <cyrus@holtmann.org>
From: Thomas Zimmermann <ml@vdm-design.de>
To: linux-bluetooth@vger.kernel.org
Subject: obexd: Question about PBAP support
Date: Fri, 22 Jan 2010 13:17:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001221317.11486.ml@vdm-design.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
i tried to write a plugin for obexd to support the phonebook of 
freesmartphone.org.

Browsing the device with "sdptool browse" shows Phonebook Access on channel 
15, so i thing obexd is running properly. But when connecting a real PBAP 
device (tried Parrot Minikit and a BMW car system) the methods in my plugin 
aren't called. (I added some debug output at the beginning of the functions 
and that's not shown.)

So, did someone tried before to use PBAP with a real device?
And how can i help to get this working?

Greets
Thomas
