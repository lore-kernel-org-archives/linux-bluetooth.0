Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Dec 2013 12:29:38 +0200
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Chlad, SebastianX" <sebastianx.chlad@intel.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add PICS, PIXITs and PTS test results for L2CAP
Message-ID: <20131217102938.GA29777@x220.p-661hnu-f1>
References: <1387147192-19246-1-git-send-email-sebastianx.chlad@intel.com>
 <20131216081736.GA8323@x220.p-661hnu-f1>
 <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2115852EF878384FA984E6B76A9F379E164297@IRSMSX104.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tue, Dec 17, 2013, Chlad, SebastianX wrote:
> To summarize: please let me know what is you stand on [ '#' notation ]
> - I'll act accordingly and then I'll push L2CAP PTS test results once
> I finish second round of testing.

I don't really care as long as it's consistent throughout all files.
Either change all places which have "True + #" to "False + #" or use the
existing convention in your new file.

Johan
