Return-Path: <cyrus@holtmann.org>
From: <tim.howes@accenture.com>
To: <Mike.Tsai@Atheros.com>
Cc: <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Nov 2010 16:03:53 +0100
Subject: RE: [PATCH] Adding a new option to specify security level for gatttool
Message-ID: <1AFE20D16950C745A2A83986B72E8748011F571E7497@EMEXM3131.dir.svc.accenture.com>
References: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org> <20101116153648.GA2710@jh-x301> <35B17FE5076C7040809188FBE7913F98406D465C43@SC1EXMB-MBCL.global.atheros.com>
In-Reply-To: <35B17FE5076C7040809188FBE7913F98406D465C43@SC1EXMB-MBCL.global.atheros.com>
Content-Type: text/plain;
	charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

-----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: Tuesday, November 16, 2010 7:37 AM
> To: Sheldon Demario
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Adding a new option to specify security level for
> gatttool
> 
> Hi Sheldon,
> 
> On Tue, Nov 16, 2010, Sheldon Demario wrote:
> > ---
> >  TODO              |    6 ------
> >  attrib/gatttool.c |   15 +++++++++++++--
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> In general the patch seems fine, but:
> 
> > +	if (strncmp(opt_sec_level, "medium", 6) == 0)
> > +		sec_level = BT_IO_SEC_MEDIUM;
> > +	else if (strncmp(opt_sec_level, "high", 4) == 0)
> > +		sec_level = BT_IO_SEC_HIGH;
> > +	else
> > +		sec_level = BT_IO_SEC_LOW;
> 
> Why do you use strncmp instead of strcmp (or even g_str_equal)? I don't
> think there's any need to map e.g. "mediumfoobar" to BT_IO_SEC_MEDIUM
> ;)
> 
> [Mtsai] I am not sure what are the definition of "low", "medium" or
> "high". By the spec of Core 4.0, LE has 2 security modes and different
> security levels based on the method of pairing (or bonding). It may be
> appeal to end user with "low", "medium" and "high" definition, but it
> can't be reference with LE spec. I would suggest, instead, following
> terms,
> 
> 	"No security",
> 	"unauthenticated encryption",
> 	"authenticated encryption",
> 	"unauthenticated data signing",
> 	"authenticated data signing,
> 
> Mike

To some extent I agree; however, the semantics of such an API would have to be careful.  A particular profile should not "force" data signing because if the link is already encrypted there is little point using data signing.  So from that point of view exposing a more abstract API (a bit like "high") is better.  However, it is hard to map "high" onto any of the ones you listed (which I agree is a good list).  So perhaps it is better to have the API semantics as "advisory" or "requests" which can be fulfilled by the underlying stack in other ways (eg encryption for data-signing).

Cheers

Tim





This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
