Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY102-W220E308B67B2F42DCEB5FFF0240@phx.gbl>
References: <5d5443650802080456p78f33f07s3ec6ac4c4c1e789c@mail.gmail.com>
	<20080208141056.GZ24072@matthew.ath.cx>
	<5d5443650802110839u2f12eb01j603dcc436085c84d@mail.gmail.com>
	<20080211164102.GA8137@berrange.com>
	<BAY102-W409DB55A6A242470BDB930F02B0@phx.gbl>
	<BAY102-W220E308B67B2F42DCEB5FFF0240@phx.gbl>
Date: Wed, 13 Feb 2008 17:30:28 +0100
Message-Id: <1202920228.7664.419.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Asynchronous SDP With DBUS API
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

Hi Robert,

> I've been playing around with the DBUS API over the past week or two
> and notice a large number of the methods implemented are asynchronous
> and send back signals when results from them are returned, however,
> this doesn't appear to be the case with an SDP enquiry placed through
> the service which appears to run synchronously.
>  
> What's the reason behind this? are we not able to have it emit a
> signal such as 'serviceFound()' or something to that effect? is this
> down to a limitation of the hardware? the stack? or am I just coding
> against the API incorrectly?
>  
> Has anyone been able to find an Asynchronous implementation for SDP
> enquiries? even if its some form of threaded work around.

actually D-Bus method calls are always asynchronous.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
