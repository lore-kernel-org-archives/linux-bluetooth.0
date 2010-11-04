Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Nov 2010 18:18:13 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix handling call waiting indicators in telephony
Message-ID: <20101104181813.GB16172@jh-x301>
References: <1288882837-9163-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288882837-9163-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 04, 2010, Lukasz Pawlik wrote:
> Previously +CIEV: "callsetup" was sent before +CCWA: (call waiting)
> notification. According to the HFP specification AG reports new
> call waiting by sending +CCWA before +CIEV indicator. Some HF did
> not handle properly ending active call after rejecting 2nd incoming call
> if "callsetup" indicator was sent before call waiting.
> ---
>  audio/telephony-maemo6.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
