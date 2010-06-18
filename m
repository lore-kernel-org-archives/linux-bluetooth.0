Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Jun 2010 11:14:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fixes sdp_get_supp_feat function
Message-ID: <20100618081407.GA32314@jh-x301>
References: <1276705848-22401-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1276705848-22401-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Wed, Jun 16, 2010, Elvis Pfützenreuter wrote:
> In case of string data items, value is a pointer by itself.
> ---
>  lib/sdp.c |   25 ++++++++++++++++++++++---
>  1 files changed, 22 insertions(+), 3 deletions(-)

The patch is now upstream. Thanks.

Johan
