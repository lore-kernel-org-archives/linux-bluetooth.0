Return-Path: <cyrus@holtmann.org>
Message-ID: <488602EB.4000704@idlum.be>
Date: Tue, 22 Jul 2008 17:55:23 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4885C0C9.7000308@idlum.be>
	<1216732834.31819.31.camel@californication>
In-Reply-To: <1216732834.31819.31.camel@californication>
Subject: Re: [Bluez-devel] Unexpected error / chronology trying to extract
 sdp handles
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

Hi Marcel,

> the SDP connection establishment might fail. This is different from from
> any low-level ACL link that you see. Run hcidump -X -V and see what
> actually does happen.

Ok, so depending on when I get it, ConnectionAttempFailed might mean 
"ACL link establishment failed", or "SDP connection failed", or 
something else when triggered from elsewhere.

And it is my duty to correctly figure out what it does mean at any given 
time. Is it right?

Regards,
Pierre-Yves



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
