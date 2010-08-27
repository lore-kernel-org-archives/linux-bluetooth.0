Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Aug 2010 15:45:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	joakim.xj.ceder@stericsson.com, arunkr.singh@stericsson.com
Subject: Re: [PATCH] BT_SECURITY_HIGH requires 16 digit pin code
Message-ID: <20100827124524.GA9484@jh-x301>
References: <1282909526-19374-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1282911133.835.30.camel@localhost.localdomain>
 <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480976E15A2C@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On Fri, Aug 27, 2010, Waldemar.Rymarkiewicz@tieto.com wrote:
> I assume that user will know that the 16 digit pin is requred, so
> should be enough to let the user type 16 digit in an agent I guess.
> Usually a service that requires high security will generate right pin
> code.

I don't think "the user should know" is enough here, so we may need to
think about ways that we could relay this info to the agent (maybe a
special adapter property or an extra parameter in the PIN request agent
callback).

> Originaly the high security level was planned to require max pin code
> lenght as I know.

That's correct, however the UI side hasn't really been considered so
far.

In general about the patches, I suspect it'll take a bit longer than
usual to get them in since the code you're touching is one of the most
sensitive ones with respect to breakage. We've finetuned it multiple
times over the last few years to get rid of IOP issues, security
vulnerabilities and to make sure all qualification tests pass. Another
reason for an expected delay is that you're introducing changes to the
kernel interface and that always requires some extra reviewing.

So how well have you tested the patches? I.e. how confident are you that
you're not introducing any regressions? Scenarios that would need to be
tested before an upstream merge are (and I'm probably forgetting several
of them):

- legacy pairing acceptor & initiator
- security mode 3 acceptor & initiator
- ssp acceptor & initiator
- renewed link key handling for both debug and normal keys
- security level upgrading (i.e. connect first to a low security socket
  and then over the same ACL to a higher security socket)
- complete and partial failure scenarios for all of the above

Additionally all these test should be done against several different
controllers due to differences in HCI interface behavior (event
ordering, error codes, etc). In that list I'd include at least one CSR,
and one Broadcom adapter and any other adapters from other manufacturers
that you can get hold of.

So how many of these tests do you already have covered? I'm not very
comfortable with pushing the patches upstream before most of the above
scenarios have been tested and verified not to introduce any
regressions.

Johan
