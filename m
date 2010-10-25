Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Oct 2010 12:22:00 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix fd comparison and comment
Message-ID: <20101025162200.GA13537@jh-x301>
References: <1288013352-23258-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1288013352-23258-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Mon, Oct 25, 2010, Elvis Pfützenreuter wrote:
> ---
>  health/hdp.c       |    6 +++---
>  health/mcap_sync.c |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Please don't mix coding style cleanup and real bug fixes into a single
patch. I.e. could you please split these up. Thanks.

Johan
