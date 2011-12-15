Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 13:16:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v1] mgmt: Add support for Passkey handling
Message-ID: <20111215111614.GA3396@x220>
References: <1323157599-5735-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323157599-5735-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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

Johan
