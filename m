Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up
	script
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040629052317.GQ20139@hp.com>
References: <20040628085356.GA8871@hp.com>
	 <1088413518.3774.167.camel@pegasus> <20040628095541.GB8871@hp.com>
	 <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com>
	 <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com>
	 <1088427271.3774.198.camel@pegasus> <20040628224803.GA20139@hp.com>
	 <1088465177.6030.221.camel@pegasus>  <20040629052317.GQ20139@hp.com>
Content-Type: text/plain
Message-Id: <1088499480.6030.239.camel@pegasus>
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
Date: Tue, 29 Jun 2004 10:58:01 +0200

Hi James,

> > from my view it is better to use "net.agent" and "pand -l" for this job.
> 
> Yes, I know.  I don't know why you think that though, since using dev-up
> costs less in dependencies and execution time.  You've proposed removing
> dev-up on the grounds that I had problems with it, and that you've never
> used it; which suggests that you think that cost of maintenance is more
> critical.  I'm just guessing.

I like to have only one and clear way to achieve a goal. And this is the
Linux hotplug mechanism from my view. However dev-up is in pand and
there was a bug, so I applied your patch. But be aware of that I might
remove it in a new major release, now I know of it ;)

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
