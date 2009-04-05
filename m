Return-Path: <cyrus@holtmann.org>
Message-ID: <20090405130856.w9g2f6pa804kg84g@webmail.unina.it>
Date: Sun, 05 Apr 2009 13:08:56 +0200
From: ranaldo@unina.it
To: linux-bluetooth@vger.kernel.org
Subject: Status of serial proxy
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I cannot find dbus api documentation for the serial proxy manager, and  
I'd like to know the current status of this part of bluez.
I guessed the parameters looking at the sources and was able to create  
and enable a tcp proxy. I'm able to see it from another box with  
sdptool, but rfcomm does not connect. I'm not sure why, however the  
profile show a channel 0, is this normal?

     Nicola Ranaldo

