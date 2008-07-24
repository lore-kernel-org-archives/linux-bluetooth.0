Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <488602EB.4000704@idlum.be>
References: <4885C0C9.7000308@idlum.be>
	<1216732834.31819.31.camel@californication> <488602EB.4000704@idlum.be>
Date: Thu, 24 Jul 2008 16:18:33 +0200
Message-Id: <1216909113.7820.16.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Unexpected error / chronology trying to
	extract	sdp handles
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

Hi Pierre-Yves,

> > the SDP connection establishment might fail. This is different from from
> > any low-level ACL link that you see. Run hcidump -X -V and see what
> > actually does happen.
> 
> Ok, so depending on when I get it, ConnectionAttempFailed might mean 
> "ACL link establishment failed", or "SDP connection failed", or 
> something else when triggered from elsewhere.

my guess in this case it means SDP connection failed since that is what
you requesting. It should not tell you about failures in other layers
since you don't care about them.

> And it is my duty to correctly figure out what it does mean at any given 
> time. Is it right?

In this case run hcidump -X -V to actually figure out what happens. It
is always possible that we have a bug somewhere that nobody has
triggered before.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
