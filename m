Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Mar 2011 11:43:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Recalculate remote SEP if the codec type changes
Message-ID: <20110318094303.GA10501@jh-x301>
References: <1300299595.2192.92.camel@snowflake>
 <1300305957-8139-1-git-send-email-arun.raghavan@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300305957-8139-1-git-send-email-arun.raghavan@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Thu, Mar 17, 2011, Arun Raghavan wrote:
> This forces recalculating the remote SEP if the local SEP's codec type
> is no longer the same as the remote SEP's codec type. This can happen
> after we issue a BT_STOP_STREAM+BT_CLOSE followed by a
> BT_SET_CONFIGURATION with a new SEID.
> ---
>  audio/a2dp.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
