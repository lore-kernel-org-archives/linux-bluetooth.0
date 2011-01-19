Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:46:18 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] Updade a2dpsink to use new Acquire API
Message-ID: <20110119151618.GE2112@jh-x301>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
 <1295344815-1404-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295344815-1404-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 18, 2011, Luiz Augusto von Dentz wrote:
> ---
>  audio/gstavdtpsink.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)

This one doesn't apply -- probably because of the glib deprecated symbol
patches which I merged first (I had to process them first since
otherwise I can't do any compilation checks on the tree). So please fix
and resend.

Johan
