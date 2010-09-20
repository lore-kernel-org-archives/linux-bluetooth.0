Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Sep 2010 14:17:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix potential NULL pointer access in MCAP CSP code
Message-ID: <20100920111716.GB15583@jh-x301>
References: <1284971729-20509-1-git-send-email-sancane@gmail.com>
 <1284971729-20509-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284971729-20509-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 20, 2010, Santiago Carot-Nemesio wrote:
> NULL pointer acces may hapen when an attemp to send a
> synchronization command happens over a closed MCL.
> ---
>  health/mcap_sync.c |   43 ++++++++++++++++++++++---------------------
>  1 files changed, 22 insertions(+), 21 deletions(-)

Thanks. This patch is also now upstream.

Johan
