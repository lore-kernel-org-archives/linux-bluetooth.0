Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jun 2010 15:04:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: harri.mahonen@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] audio: fix memory leak with typefinding
Message-ID: <20100629120447.GA9544@jh-x301>
References: <1277391672-10563-1-git-send-email-harri.mahonen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277391672-10563-1-git-send-email-harri.mahonen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harri,

On Thu, Jun 24, 2010, harri.mahonen@gmail.com wrote:
> From: Harri Mahonen <harri.mahonen@gmail.com>
> 
> Each time sbc_typefind is called and there is no syncword, sbc_finalize
> never gets called. Instead of hardcoded syncword check, rely on
> sbc_parse to do it properly.
> ---
>  audio/gstbluetooth.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)

This patch has now been pushed upstream. Thanks.

Johan
