Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Jul 2011 14:41:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 1/2] Convert dos file to unix
Message-ID: <20110703114150.GB10186@dell.ger.corp.intel.com>
References: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Jul 02, 2011, Lucas De Marchi wrote:
> Call `tr -d \\r < tools/ubcsp.c', and since this will change all the
> lines, remove the trailing white spaces too.
> ---
>  tools/ubcsp.c | 2360 ++++++++++++++++++++++++++++----------------------------
>  1 files changed, 1180 insertions(+), 1180 deletions(-)

I'm not really sure this is worth it since it'll e.g. screw up "git
blame" for this file. If it was a file that's likely to receive updates
it'd be different, but since the last change to it was from 2008 I don't
see that as likely. OTOH I don't really have such a strong opinion about
this, so if Marcel is fine with it we can apply the patch upstream.

Johan
