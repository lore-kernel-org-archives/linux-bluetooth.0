Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY111-F1375482293258DA33AFC60C1090@phx.gbl>
In-Reply-To: <1183042761.9499.25.camel@aeonflux.holtmann.net>
From: "Clark Pope" <cepope13@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 28 Jun 2007 11:48:25 -0400
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

So you think the problem shown in the log is related to the kernel version, 
not just some configuration issue? I think the bluetooth part is working it 
just rejects the connect for some reason. Thanks


>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
>To: BlueZ development <bluez-devel@lists.sourceforge.net>
>CC: bluez-devel@lists.sf.net
>Subject: Re: [Bluez-devel] Trouble with bluetooth headset
>Date: Thu, 28 Jun 2007 16:59:21 +0200
>
>Hi Clark,
>
> > I have a colleague that is stuck trying to get a bluetooth headset 
>working.
> > The system is montavista linux 2.6.10 on x86 for development and PPC for
> > deployment. Below is his request to me. Any help/guidance you can 
>provide is
> > greatly appreciated. Also, if you can recommend a known good combination 
>of
> > headset and usb dongle that has working drivers for PPC405 (Xilinx SOC) 
>it
> > would save us the trouble of fixing this one.
>
>the 2.6.10 kernel is highly outdated. Switch to the upcoming 2.6.22
>kernel. We are not supporting these old kernels and I am not doing any
>backports for it.
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
