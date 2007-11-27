Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <474BD737.5010905@pracucci.com>
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
	<1192630825.6184.17.camel@violet>
	<f8e53fb0711250754n60de59f7md759b9d21f39ec53@mail.gmail.com>
	<1196055392.4217.41.camel@aeonflux>
	<f8e53fb0711270003r2e32f78ev18205a8381d750d3@mail.gmail.com>
	<1196152161.17196.20.camel@aeonflux>  <474BD737.5010905@pracucci.com>
Date: Tue, 27 Nov 2007 09:43:08 +0100
Message-Id: <1196152988.17196.25.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] concurrent calls to RFCOMM connect()
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

Hi Marco,

> > I think your kernel is too old, because we fixed that. However the
> > kernel only queues the attempt. It won't make it faster since we can't
> > serialize the baseband/radio.
> >   
> In which kernel version did you add this feature?

it is part of 2.6.19 and later.

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
