Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY111-F3396AF6D1AA97A5F3F713CC10F0@phx.gbl>
In-Reply-To: <1183045954.9499.35.camel@aeonflux.holtmann.net>
From: "Clark Pope" <cepope13@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 30 Jun 2007 14:09:48 -0400
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Trouble with bluetooth headset
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




>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
>To: BlueZ development <bluez-devel@lists.sourceforge.net>
>CC: bluez-devel@lists.sf.net
>Subject: Re: [Bluez-devel] Trouble with bluetooth headset
>Date: Thu, 28 Jun 2007 17:52:34 +0200
>
>Hi Clark,
>
> > So you think the problem shown in the log is related to the kernel 
>version,
> > not just some configuration issue? I think the bluetooth part is working 
>it
> > just rejects the connect for some reason.
>
>I don't even know, but I am simply not chasing any bugs from people that
>don't run at least a reasonable new kernel. And 2.6.10 is ancient. If
>someone else wanna look at it, it is fine by me, but I won't until you
>have this issue with a recent kernel and latest bluez-utils.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel

Guess I should clarify, the original base was 2.6.10 but montavista has 
about 1200 patches applied to it so I'm not sure what the true rev level is 
compared to the stock kernel tree. But the other bluetooth devices seem to 
work okay. Just seems something odd particularly for audio and this 
authentication business with the headset. Any suggestions at all are 
appreciated. -Clark

_________________________________________________________________
Like puzzles? Play free games & earn great prizes. Play Clink now. 
http://club.live.com/clink.aspx?icid=clink_hotmailtextlink2


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
