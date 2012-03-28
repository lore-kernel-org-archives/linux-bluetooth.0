Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 12:39:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Omit MainChannel when HDP first reliable channel is
 nil
Message-ID: <20120328093928.GB28310@x220>
References: <1332853405-16495-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1332853405-16495-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Tue, Mar 27, 2012, Elvis Pfützenreuter wrote:
> Do not add MainChannel to property list when HDP first reliable channel
> does not exist. Upon channel destruction, ChannelDeleted signal is already
> emitted.
> 
> This also fixes a crash where MainChannel was filled with invalid path ""
> when first reliable channel did not exist.
> ---
>  health/hdp.c |   15 +++------------
>  1 files changed, 3 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
