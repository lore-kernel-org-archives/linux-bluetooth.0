Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Thu, 26 Jun 2008 22:42:47 +0000 (UTC)
Message-ID: <loom.20080626T223113-455@post.gmane.org>
References: <52cf60ee0806261127r15b88ccod1bdba8d42ed4e59@mail.gmail.com>
	<1214514474.23682.42.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Meaning of hcitool -i dev con
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

Marcel Holtmann <marcel <at> holtmann.org> writes:

> > 	> SCO 00:19:2C:D5:90:DF handle 2 state 1 lm SLAVE
> > 	< ACL 00:19:2C:D5:90:DF handle 1 state 1 lm MASTER ENCRYPT
> > 
> > Does this mean that the USB adapter is playing TWO roles (master and
> > slave) at the same moment??
> 
> that is for the SCO connection. The ACL connection is the one that
> counts. The SCO depends on the ACL connection.
> 
> Actually the the SCO/eSCO connections don't have a link mode. It is an
> issue how these information are presented.
> 
> Regards
> 
> Marcel
> 
Thank you for the explanation.
This explains the output from hci command and hcidump.
Your words also reminds me that standard has said "before creating SCO, a ACL
link must exist".
But I am still confused about the handle.
If ACL first use handle 0, does that mean the upcoming SCO will use handle 0? 
Or another one?

If you have some time, please also try to look at my previous post "Multiple SCO
connections".

Sincerely,
Jui-Hao




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
