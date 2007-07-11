Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707110700j41924ecsf689767939918342@mail.gmail.com>
Date: Wed, 11 Jul 2007 08:00:05 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <a92460650707110649l6d1a4f76s82921b2116992781@mail.gmail.com>
MIME-Version: 1.0
References: <a92460650707110649l6d1a4f76s82921b2116992781@mail.gmail.com>
Subject: Re: [Bluez-users] Pairing a phone with linux and windows at same
	time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

John

> Windows and Linux are in the same computer.

The problem is both operating systems share the same adapter but don't
share any of the state that is built up during pairing.

You could change between two bluetooth adapters on your computer so
the phone doesn't get confused. There are even hacks where you use
just one adapter and temporarily change the mac addr on the adapter
when under linux.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
