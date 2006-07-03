Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151937859.8418.26.camel@localhost.localdomain>
References: <1151937859.8418.26.camel@localhost.localdomain>
Date: Mon, 03 Jul 2006 17:14:25 +0200
Message-Id: <1151939665.12125.16.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] PAN Profile: NAP & GN at the same time ???
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Olivier,

> I wonder wether it is possible or not to have a bluetooth device which
> manages a NAP and a GN connection at the same time.
> If we consider BlueZ implementation, it is not possible: 
> pand --listen --role NAP -n
> pand[10750]: Bluetooth PAN daemon version 2.20
> pand[10750]: Bind failed. Address already in use(98)
> And it is a normal behaviour when we consider that NAP & GN both use
> BNEP so PSM=0x0F=15.
> I also have a look at Bluetooth and PAN profile specs and nothing
> seems to prevent us from doing such a thing.
> So my question is: does PSM aspect imply that it is not possible to
> manage 2 master services at the same time or is there solution to do
> that ???

you have to modify pand so it registers both SDP records. Since you can
have only one listen socket on PSM 15 you must do any multiplexing
inside pand itself.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
