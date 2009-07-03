Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jul 2009 17:43:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] move tools/l2ping.1 to man section 8
Message-ID: <20090703144328.GA18534@jh-x301>
References: <1246445925-14815-1-git-send-email-filippo@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246445925-14815-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

On Wed, Jul 01, 2009, Filippo Giunchedi wrote:
> usually only root is able to invoke l2ping thus move to man section 8
> ---
>  tools/Makefile.am |    2 +-
>  tools/l2ping.1    |   76 -----------------------------------------------------
>  tools/l2ping.8    |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 77 deletions(-)

This one is now pushed upstream. Thanks.

Johan
