Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <200712202240.34586.post@hendrik-sattler.de>
References: <200712192341.02293.post@hendrik-sattler.de>
	<200712200229.40589.post@hendrik-sattler.de>
	<1198116580.8050.232.camel@aeonflux>
	<200712202240.34586.post@hendrik-sattler.de>
Date: Fri, 21 Dec 2007 00:12:32 +0100
Message-Id: <1198192352.8050.269.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP services cannot be unregistered
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

Hi Hendrik,

> > first of all you are using the unregister function wrongly. You have to
> > give it the exact record structure you gave the register function. So
> > when you allocate a new record, then the unregister has no idea what to
> > do with it.
> 
> Ok, I remember now everything related to the record and it works. One note 
> though: the sdp_record_free() function always crashes. Is it actually 
> supposed to be used? Or asked the other way: how is one supposed to free the 
> previously allocated stuff correctly? Or is this done automatically?

actually I can't remember. There might be some cases where the
unregister function actually frees the record. The SDP code is not
something anybody can be proud of.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
