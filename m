Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4639D5E2.3090703@gmail.com>
Date: Thu, 03 May 2007 09:30:26 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>	<1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com><22b6c3510705022305s522c254fy511ee6e9db90c44c@mail.gmail.com>	<4639D350.2020606@gmail.com>
	<2EB6297382462046A9427D7324788A4801D5E78A@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <2EB6297382462046A9427D7324788A4801D5E78A@MCLNEXVS06.resource.ds.bah.com>
Subject: Re: [Bluez-devel] finding the least busy hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Williams, Richard escribi=F3:
> I think the solution is pretty simple, and is done entirely at the
> application level. I wrote an app that uses multiple dongles, for HCI
> commands, SDP and OBEX. I have an array of hci control objects that I
> "alloc" and "free" just as you would any other shared resource. =

>
> Whenever I need to do a BT operation, the app goes to the pool of HCI
> devices and requests one with "hci_alloc()". If one is free, that "hciX"
> is returned. If none is free, then NULL is returned. When the app is
> done with the operation, I do an "hci_free()".
>   =

That's what I'm doing so far, I'm doing it all from a bash script, I =

keep the count of hci dongles I have and then open one connection one =

per hci. And I count how many hci connections each hci has.
But that's not the best for sure.
Thanks,
Manuel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
