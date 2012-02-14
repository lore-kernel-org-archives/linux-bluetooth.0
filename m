Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 15:03:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd 6/6] client: queue transfers in pbap sessions
Message-ID: <20120214130315.GG19427@x220.ger.corp.intel.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329143945-4934-6-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329143945-4934-6-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 13, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Previous implementation reported busy when trying to queue several
> operations in the same session.
> ---
>  client/pbap.c |  127 +++++++++++++++++++++++++++++---------------------------
>  1 files changed, 66 insertions(+), 61 deletions(-)

This one doesn't apply either without the other patches that need
fixing. I've applied patches 1 and 5 though so no need to resend them.

Johan
