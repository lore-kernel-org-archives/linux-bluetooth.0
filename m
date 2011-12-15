Return-Path: <cyrus@holtmann.org>
From: Hemant GUPTA <hemant.gupta@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Naresh-kumar GUPTA <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Thu, 15 Dec 2011 12:37:16 +0100
Subject: RE: [PATCH v1] mgmt: Add support for Passkey handling
Message-ID: <AA50405D3B026C488CB3DB0AADE695401F5699724D@EXDCVYMBSTM005.EQ1STM.local>
References: <1323157599-5735-1-git-send-email-hemant.gupta@stericsson.com>
 <20111215111614.GA3396@x220>
In-Reply-To: <20111215111614.GA3396@x220>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: Thursday, December 15, 2011 4:46 PM
To: Hemant GUPTA
Cc: linux-bluetooth@vger.kernel.org; Naresh-kumar GUPTA; Hemant Gupta
Subject: Re: [PATCH v1] mgmt: Add support for Passkey handling

Hi Hemant,

On Tue, Dec 06, 2011, Hemant Gupta wrote:
> This patch adds support for handling Passkey Requests
> and response over management interface.
> ---
>  lib/mgmt.h        |   17 ++++++++++
>  plugins/mgmtops.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 92 insertions(+), 10 deletions(-)

This will need to be rebased against latest upstream git since it
doesn't apply anymore. Also note that the mgmt structs and definitions
are already in place so you don't need to add those.

Thanks for the info, I will rebase, and upload a new patch for review soon.

Johan

BR
Hemant
