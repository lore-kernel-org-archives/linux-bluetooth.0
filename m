Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jun 2011 21:57:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Implement fast connectable mode for mgmt interface
Message-ID: <20110616185740.GA11601@dell.ger.corp.intel.com>
References: <1308225321-15910-1-git-send-email-antti.julku@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308225321-15910-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

On Thu, Jun 16, 2011, Antti Julku wrote:
> Management interface implementation for fast connectable mode.
> ---
>  doc/mgmt-api.txt  |    8 ++++++++
>  lib/mgmt.h        |    5 +++++
>  plugins/mgmtops.c |   24 +++++++++++++++++++++---
>  3 files changed, 34 insertions(+), 3 deletions(-)

Now that your blacklist patch has been applied this one doesn't apply
cleanly anymore, so you'll have to rebase against the upstream tree.

Johan
