Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up
	script
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040628224803.GA20139@hp.com>
References: <20040627233437.GD28828@hp.com>
	 <1088408656.3774.136.camel@pegasus> <20040628085356.GA8871@hp.com>
	 <1088413518.3774.167.camel@pegasus> <20040628095541.GB8871@hp.com>
	 <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com>
	 <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com>
	 <1088427271.3774.198.camel@pegasus>  <20040628224803.GA20139@hp.com>
Content-Type: text/plain
Message-Id: <1088465177.6030.221.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Jun 2004 01:26:17 +0200

Hi James,

> > what do you wanna do with that information? Actually I never needed it.
> 
> Select access policies.  Probably not a terribly reliable access
> control, but at least ringing alarms if I sight a connection from an
> unexpected address would be useful.

from my view it is better to use "net.agent" and "pand -l" for this job.
If it gets to complex then you should integrate it directly into pand.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
