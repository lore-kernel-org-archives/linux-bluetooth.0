Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <F73F58A0-A537-4ACE-8C56-D5F2D6735F61@wideray.com>
References: <435B3A56-B448-4E26-8BEB-E0879356ACBB@wideray.com>
	<1150538876.17539.0.camel@aeonflux.holtmann.net>
	<F73F58A0-A537-4ACE-8C56-D5F2D6735F61@wideray.com>
Date: Mon, 19 Jun 2006 20:27:27 +0200
Message-Id: <1150741647.4277.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bug: infinite loop in extract_seq()
	when	sdp_extract_seqtype() fails
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

Hi Jason,

> >> It appears that extract_seq() in sdp.c (bluez-libs) can enter an
> >> infinite loop if sdp_extract_seqtype() fails when extract_seq() has
> >> called itself recursively.  Here's how:
> >
> > Do you have a patch for it or can you send a small reproducer program?
> 
> This may be a false alarm.  When I looked closer, I could not explain  
> how the program could reach the state I described.  The problem is  
> that sdp_extract_attr() only calls extract_seq() for aggregate  
> types.  In fact, exactly those types that sdp_extract_seqtype()  
> expects.  With that invariant, I don't see how the program could fall  
> into the loop I described, not without resorting to exotic explanations.
> 
> All I know at this point is that /var/log/messages gets an endless  
> flood of
> 
>    sdp_extract_seqtype: Unknown sequence type, aborting
> 
> We don't know yet what triggers this.  Of course I will follow up if  
> it still turns out to be a problem in bluez.

it is kinda likely that SDP still have endless loops in it. However
please make sure you use the latest bluez-libs from CVS and really run
the latest sdpd and/or sdptool.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
