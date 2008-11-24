Return-Path: <cyrus@holtmann.org>
Message-Id: <CD3D79B9-7C76-4B31-8861-C61306B4714E@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e343e5940811190907h743ce8bbr4eb81b8ef50d1dd4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Mon, 24 Nov 2008 03:44:56 +0100
References: <e343e5940811190907h743ce8bbr4eb81b8ef50d1dd4@mail.gmail.com>
Subject: Re: [Bluez-devel] Connection proccess
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Yuriy,

> Can you tell me, please, how many concurrent connections  (i mean  
> proccess of connection) can be done on one dongle?
>
> for example:
>
> hcitool con
> Connections:
>         < ACL 00:1C:9A:6E:27:4A handle 0 state 5 lm MASTER
>         < ACL 00:16:BC:31:EE:2E handle 0 state 5 lm MASTER
>         < ACL 00:16:B8:AE:75:7E handle 3 state 1 lm MASTER
>         < ACL 00:18:0F:AC:BF:EE handle 2 state 1 lm MASTER
>         < ACL 00:1E:4C:D4:0C:52 handle 1 state 1 lm MASTER
>
> Does "handle 0" mean that there is a try of low level connection?
>
> I've not seen "handle 0" more then 3 times.

decode the state. It is BT_CONNECT. And actually only one connect  
attempt can be made at a time. Some hardware queues it for you. For  
others we have to do it and then this should show state BT_CONNECT2.

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
