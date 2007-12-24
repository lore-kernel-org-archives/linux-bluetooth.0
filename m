Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU117-W35384D9D521C82D28811E588590@phx.gbl>
References: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
	<d89ddf300712210752p24070ee5i33d17a427e3c31c@mail.gmail.com>
	<BLU117-W24F980AF55D11A07E6B6E688590@phx.gbl>
	<d89ddf300712231836m32ea9778o72a300c47cac18e@mail.gmail.com>
	<BLU117-W1270E7F77535BE008FEAF288590@phx.gbl>
	<d89ddf300712232026y32878c5x4b1e61ac0cee712c@mail.gmail.com>
	<BLU117-W35384D9D521C82D28811E588590@phx.gbl>
Date: Mon, 24 Dec 2007 11:47:05 +0100
Message-Id: <1198493225.8050.315.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a2dp choppy sound problem
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

Hi Benson,

> > is it running on a slow computer or an embedded computer?
> 
> It is running on CentOS 5.0(VMware) on x86 , 1G Mem ,PD3.2GHz .
> I just compiled and installed bluez-libs 3.22 and bluez-utils 3.22 .

if you run this inside VMware then it is not guaranteed to work at all.
The latency that the USB emulation of VMware imposes makes it impossible
to use it properly. We have seen this with VMware Fusion on MacBooks
already.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
