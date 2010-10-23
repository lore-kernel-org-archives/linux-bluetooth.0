Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 Oct 2010 10:28:28 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix small coding style issues
Message-ID: <20101023122828.GA19333@jh-x301>
References: <1287775122-12536-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1287775122-12536-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Fri, Oct 22, 2010, Elvis Pfützenreuter wrote:
> Based on http://lxr.linux.no/linux+v2.6.36/Documentation/CodingStyle#L171
> ---
>  health/hdp_util.c |   24 +++++++++++++-----------
>  health/mcap_lib.h |    8 ++++----
>  2 files changed, 17 insertions(+), 15 deletions(-)

Thanks, I've pushed the patch upstream. FWIW, The BlueZ code base
doesn't really enforce the kernel style rule of having braces for all
parts of if-else statements when at least one branch has them.

Johan
