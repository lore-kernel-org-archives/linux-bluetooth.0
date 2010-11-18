Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 14:19:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: tim.howes@accenture.com
Cc: Mike.Tsai@Atheros.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding a new option to specify security level for
 gatttool
Message-ID: <20101118121952.GA3609@jh-x301>
References: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org>
 <20101116153648.GA2710@jh-x301>
 <35B17FE5076C7040809188FBE7913F98406D465C43@SC1EXMB-MBCL.global.atheros.com>
 <1AFE20D16950C745A2A83986B72E8748011F571E7497@EMEXM3131.dir.svc.accenture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1AFE20D16950C745A2A83986B72E8748011F571E7497@EMEXM3131.dir.svc.accenture.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

Nice to see you on this list! :)

On Wed, Nov 17, 2010, tim.howes@accenture.com wrote:
> > [Mtsai] I am not sure what are the definition of "low", "medium" or
> > "high". By the spec of Core 4.0, LE has 2 security modes and different
> > security levels based on the method of pairing (or bonding). It may be
> > appeal to end user with "low", "medium" and "high" definition, but it
> > can't be reference with LE spec. I would suggest, instead, following
> > terms,
> > 
> > 	"No security",
> > 	"unauthenticated encryption",
> > 	"authenticated encryption",
> > 	"unauthenticated data signing",
> > 	"authenticated data signing,
> 
> To some extent I agree; however, the semantics of such an API would
> have to be careful.  A particular profile should not "force" data
> signing because if the link is already encrypted there is little point
> using data signing.  So from that point of view exposing a more
> abstract API (a bit like "high") is better.  However, it is hard to
> map "high" onto any of the ones you listed (which I agree is a good
> list).  So perhaps it is better to have the API semantics as
> "advisory" or "requests" which can be fulfilled by the underlying
> stack in other ways (eg encryption for data-signing).

Something like that will probably be needed, yes. However the idea of
the current command line switch to gatttool is to simply map to the
existing kernel API, and that API only has low, medium and high. So at
least in the short term the patch is fine.

Johan
