Return-Path: <cyrus@holtmann.org>
Message-ID: <5341D403.8050001@gmx.net>
Date: Mon, 07 Apr 2014 00:24:03 +0200
From: Tobias Jakobi <liquid.acid@gmx.net>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
References: <530FBB6B.8080300@gmx.net>	<CAJdJm_P9FD+NwSAfG=1bWg0Ep2Ku7eTqwpLN2aX6p5-+rc=3sA@mail.gmail.com>	<5310BFEF.8010405@gmx.net> <CAJdJm_PVX=97RPVUJ5qx9k-OFNt=xidLrwgL6qK9QTTRBJHd+Q@mail.gmail.com> <53137E6E.7080305@gmx.net> <534179D4.4040607@gmx.net>
In-Reply-To: <534179D4.4040607@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------060406080106060702050105"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060406080106060702050105
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tobias Jakobi wrote:
> Just a small note that I updated the bluez stacks (both on the server
> and the client) to 5.17. However the issue remains.
> 
> I've also created log from the debug output of bluetoothd on both sides:
> http://www.math.uni-bielefeld.de/~tjakobi/bt-client.log
> http://www.math.uni-bielefeld.de/~tjakobi/bt-server.log
> 
> Has anyone here actually managed to get a working TCP/IP network with
> recent bluez stack?
> 
> Greets,
> Tobias
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I think I isolated the issue. The problem is that the profiles that are
associated to the NAP, PANU and GN services haven't got the auto_connect
flag set.

So during connect_profiles() they're never considered, and there is no
way to change this via the cmdline tools. Which effectively disables
this functionality.

Maybe the DBus interface can change these setting for built-in profiles,
but you honestly can't expect the enduser to fiddle around with that.

I attached a patch which enables autoconnect for all the above services.
This finally establishes the TCP/IP connection for me.

Greets,
Tobias


--------------060406080106060702050105
Content-Type: text/x-patch;
 name="0001-network-enable-autoconnect-for-NAP-PANU-and-GN.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-network-enable-autoconnect-for-NAP-PANU-and-GN.patch"

>From 25f98aa8bbce7763fc68402c7aeedf90f431e7de Mon Sep 17 00:00:00 2001
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Date: Sun, 6 Apr 2014 23:58:32 +0200
Subject: network: enable autoconnect for NAP, PANU and GN

---
 profiles/network/manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 0fe98a0..9b501a3 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -137,6 +137,7 @@ static struct btd_profile panu_profile = {
 	.name		= "network-panu",
 	.local_uuid	= NAP_UUID,
 	.remote_uuid	= PANU_UUID,
+	.auto_connect	= true,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
@@ -149,6 +150,7 @@ static struct btd_profile gn_profile = {
 	.name		= "network-gn",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= GN_UUID,
+	.auto_connect	= true,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
@@ -161,6 +163,7 @@ static struct btd_profile nap_profile = {
 	.name		= "network-nap",
 	.local_uuid	= PANU_UUID,
 	.remote_uuid	= NAP_UUID,
+	.auto_connect	= true,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
 	.connect	= connection_connect,
-- 
1.8.3.2


--------------060406080106060702050105--
