Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Apr 2010 10:46:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Added memory checks whenever memory is allocated in SDP
Message-ID: <20100428074642.GA30577@jh-x301>
References: <1272439009.2203.3.camel@mosquito>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272439009.2203.3.camel@mosquito>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 28, 2010, Santiago Carot-Nemesio wrote:
> This patch checks memory allocated with malloc and removes uneccessary (**void) castings.
> 
> >From d80347d56e730388d1eca190e60c3c09ac62db27 Mon Sep 17 00:00:00 2001
> From: Santiago Carot-Nemesio <sancane@gmail.com>
> Date: Wed, 28 Apr 2010 09:10:24 +0200
> Subject: [PATCH] Added memory checks whenever memory is allocated in SDP
> 
> ---
>  lib/sdp.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 77 insertions(+), 10 deletions(-)

Thanks. This one is now pushed upstream after (still) some manual
editing of the commit message for it to not contain longer lines than 74
characters (the lines should be short enough for them to fit into a
80-character wide terminal when doing "git log").

Johan
