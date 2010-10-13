Return-Path: <cyrus@holtmann.org>
Message-ID: <734620.13775.qm@web65716.mail.ac4.yahoo.com>
Date: Wed, 13 Oct 2010 08:45:12 -0700 (PDT)
From: Greg Mercurio <gmercurio@yahoo.com>
Subject: Enabling SCO mode
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am new to Bluez and have a question about sco audio.  I am using Bluez version 4.47 in an Android environment.  

The Bluetooth chip I’m using is initialized to use the PCM interface for sco audio data.  So, the chip should be ready to transmit the sco audio when enabled.  

>From what I can tell by looking at the Android code, the Bluetooth Handsfree Java application in initiates a sco connection by opening a sco socket connection with the stack.  

I assume that opening the sco connection will send vendor independent HCI commands to the Bluetooth chip to put it into sco mode.  I don’t see in the code where this is done.

Can someone confirm my assumptions and point me to the place in the code where enabling the sco commands are sent to the chip?

Thanks,
Greg


      
