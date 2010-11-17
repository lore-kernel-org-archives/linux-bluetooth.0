Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: "tim.howes@accenture.com" <tim.howes@accenture.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Nov 2010 08:57:38 -0800
Subject: RE: [PATCH] Adding a new option to specify security level for
 gatttool
Message-ID: <35B17FE5076C7040809188FBE7913F98406D465C7D@SC1EXMB-MBCL.global.atheros.com>
References: <1289913613-3717-1-git-send-email-sheldon.demario@openbossa.org>
 <20101116153648.GA2710@jh-x301>
 <35B17FE5076C7040809188FBE7913F98406D465C43@SC1EXMB-MBCL.global.atheros.com>
 <1AFE20D16950C745A2A83986B72E8748011F571E7497@EMEXM3131.dir.svc.accenture.com>
In-Reply-To: <1AFE20D16950C745A2A83986B72E8748011F571E7497@EMEXM3131.dir.svc.accenture.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

-----Original Message-----
From: tim.howes@accenture.com [mailto:tim.howes@accenture.com] 
Sent: Wednesday, November 17, 2010 7:04 AM
To: Mike Tsai
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: [PATCH] Adding a new option to specify security level for gatttool

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

[Mtsai] I fully embrace the "abstract" API concept. However, all new LE profiles have clearly defined the security request per each attribute now. As a generic attribute profile (as GATT), without clear indication from Application what level of security is requested, GATT/GAP can handle the security request incorrectly and cause IOP issues. For example, what does "low" mean when GAP/SM gets this request from Application? It does not tell GAP/SM what kind of pairing shall be performed and if encryption or data signing for accessing the attributes. 

Cheers,

Mike





This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
