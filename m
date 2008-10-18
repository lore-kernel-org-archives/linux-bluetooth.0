Return-Path: <cyrus@holtmann.org>
Message-ID: <48F9A964.2030107@dtsp.co.nz>
Date: Sat, 18 Oct 2008 22:16:20 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Sending files via bluez-gnome
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi people,

I notice that the "Send files to device" menu item off bluetooth-applet 
is only available if "obex-data-server" is in the $PATH.  But I get the 
impression that "obexd" is trying to provide the DBus service that the 
applet is actually after (point being that searching the $PATH for 
"obex-data-server" isn't a very good test for "obexd" presence :)

Sadly, either way (running either server) I can't seem to transfer files 
to my Blackberry.  But that could be a Blackberry problem, its Bluetooth 
support is pretty dismal...

Cheers,

Dave
