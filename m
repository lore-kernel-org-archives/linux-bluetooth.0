Return-Path: <cyrus@holtmann.org>
Message-ID: <4FF35AC4.7010204@tu-ilmenau.de>
Date: Tue, 03 Jul 2012 22:49:08 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: problem with bluez-test
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I just installed openSUSE12.1 and bluez and bluez-test on two PC's.
But I can't create a connection between these two PC's even though I 
spend a long time searching the internet.
That's my problem:
I have a USB-Bluetooth3.0-dongle at each PC and I can create a 
connection via
     PC1 # rfcomm listen 0 1
     PC2 # rfcomm -r connect 0 <remote-address> 1

But I can't create a bnep-connection via test-network even though 
NetworkManager runs in the background. What am I doing wrong?
     PC1 # test-network <remote-address> NAP
     Traceback (most recent call last): File "/usr/bin/test-network", 
line 45, in <module> iface = network.Connect(service) File 
"/usr/lib/python2.7/site-packages/dbus/proxies.py", line 68, in __call__ 
return self._proxy_method(*args, **keywords) File 
"/usr/lib/python2.7/site-packages/dbus/proxies.py", line 140, in 
__call__ **keywords) File 
"/usr/lib/python2.7/site-packages/dbus/connection.py", line 630, in 
call_blocking message, timeout) dbus.exceptions.DBusException: 
org.freedesktop.DBus.Error.UnknownMethod: Method "Connect" with 
signature "s" on interface "org.bluez.Network" doesn't exist

I believe I use a wrong syntax, do I? There is probably missing some 
kind of "listen"-command at the remote site.
But sadly I don't find any man-page for "test-network".

Hope you can explain a little how i can setup my bnep-connection.

Regards,
Steffen
