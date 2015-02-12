Return-Path: <cyrus@holtmann.org>
Message-ID: <54DC816C.2060806@my.bristol.ac.uk>
Date: Thu, 12 Feb 2015 10:33:16 +0000
From: Christopher Bainbridge <cb0128@my.bristol.ac.uk>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: NetworkServer1 exits when program exits
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been trying to get NetworkServer1 service working without using 
Python, as I'm working on a platform with limited resources. When I use 
dbus-send...

dbus-send --system --type=method_call --dest=org.bluez --print-reply 
/org/bluez/hci0 org.bluez.NetworkServer1.Register string:nap string:tether

I see the server registering, but then immediately unregistering. 
According to the API documentation (doc/network-api.txt), this is what 
is supposed to happen.

Experimenting with Python on my PC, removing the 'unregister' line from 
the test-nap script makes no difference at all (I get no error that the 
NAP server is already registered, which I get if I run test-nap twice at 
the same time). But this then removes the need for the 
NetworkServer1.Unregister method call, and doesn't allow me to use 
dbus-send to enable the NAP server.

May I suggest that the NetworkServer1.Register method call doesn't 
unregister when it exits? Or is there another way of registering a NAP 
server that doesn't involve dbus-send or Python?

Thanks
Chris
