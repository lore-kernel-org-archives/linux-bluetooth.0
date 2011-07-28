Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 10:56:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix mem leak in sap plugin
Message-ID: <20110728075631.GA4204@dell>
References: <1310729911-12075-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310729911-12075-1-git-send-email-arkadiusz.lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

On Fri, Jul 15, 2011, Arek Lichwa wrote:
> When dropping rfcomm channel to sap server, the component's channel
> cleanup process doesn't release assigned glib channel resources.
> ---
>  sap/server.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied. I had to actually look at the code to determine that the patch
is correct since your commit message doesn't really explain the
situation clearly enough (which is also why you got initial doubts from
Luiz).

Johan
