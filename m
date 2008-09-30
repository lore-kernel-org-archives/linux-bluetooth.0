Return-Path: <cyrus@holtmann.org>
Message-ID: <48E2524E.1040705@wurmsdobler.org>
Date: Tue, 30 Sep 2008 17:22:38 +0100
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <000001c92311$869c0d80$93d42880$@savary@kerlink.fr>
In-Reply-To: <000001c92311$869c0d80$93d42880$@savary@kerlink.fr>
Subject: Re: [Bluez-users] bccmd 3.36 for arm
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Salut Pierre,
> I search the "bccmd" binary (bluez-utils-3.36) for ARM. It's really
> important and I cannot compile it. Where can I find it?
In bluez-utils 3.26 it was tools/bccmd.c . In order to have it compiled 
bluez-utils needs to be configured:
	./configure --enable-bccmd
Hope this helps,
peter


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
