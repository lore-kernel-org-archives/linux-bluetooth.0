Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: TJ <tj.trevelyan@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 25 Apr 2007 10:00:47 +0100
References: <6849c8890704200342k23f7e54ckaf0920197c4e5e1a@mail.gmail.com>
	<6849c8890704240209q46c5ec3ai47241251f7142ebf@mail.gmail.com>
	<462DD3B5.8060702@access-company.com>
MIME-Version: 1.0
Message-Id: <20070425090159.8C29EF5533@mail1.norse.ukerna.ac.uk>
Subject: Re: [Bluez-users] A2DPD fails to init with a2dp_make_listen_socket:
	(errno=13:Permission denied)Cannot bind socket
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> Hi,
> thank you for the softvol trick.
> It looks like you already have a2dpd running.
> maybe killall a2dpd before could help
> 

No, it's definitely not already running. Its not listed in ps -Af, and I
have even rebooted. headsetd is not running either.

Thorben


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
