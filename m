Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
References: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
Date: Thu, 18 Sep 2008 19:11:50 +0200
Message-Id: <1221757910.6782.17.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What happens with bluetooth when connection
	is	interrupted
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Reto,

> I have a little question. I have to develop an Application where it
> can happen that the connection interrupts. I poll the adapter every
> second to see if I am still connected to the specific device. Now I
> have to know if there is a possibility that the bluez-function
> "isConnected(string address)" (D-Bus-Function) returns false but the
> connection itself is recovered by the BT-Stack so the connection would
> still exist.

whatever you do don't poll for a status. You will get a D-Bus signal if
you are connected or paired etc. Check how bluez-gnome is doing it.

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
