Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: bnep module use count ...
Date: Sun, 7 Mar 2004 03:34:32 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403070334.32315.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

I have a theory about this module use count.

What is my setup.

When I insert the usb dongle, hci/sdp and pand --listen is started wating for 
a connection.

Then I activate the connection on my Ipaq and notice in syslog that the 
connection is request.

Pand will then create a bnep module in the kernel.  This will trigger a 
hotplug event causing ifup to be executed on bnep0.

So far so good.

Now I disconnect my Ipaq. (either by pand -k and kill or whatever).  
This event does not get detected by anybody.

The Ipaq when it comes back will request a new session and a new handle to 
bnep0 is created in the kernel (causing refcount to increase beyond the real 
use count).

Once this occurs the module is no longer unloadable and actually causes the 
system to hang when the usb dongle is removed !!!! A reboot is then 
needed ;-((((((

WHat you think of this scenario ?

W
