Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 16:27:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Setting default Link Policy according to the chip
 supported features
Message-ID: <20101213142725.GA15075@jh-x301>
References: <1292249954-8544-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292249954-8544-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pawel,

On Mon, Dec 13, 2010, Pawel Wieczorkiewicz wrote:
> By default all features are enabled (RSWITCH, HOLD, PARK, SNIFF).
> When "read local supported features" complete event occurs, not supported
> features are disabled and then "Write default link policy" command with
> supported features is sent.
> 
> On behalf of ST-Ericsson SA
> ---
>  plugins/hciops.c |   35 +++++++++++++++--------------------
>  1 files changed, 15 insertions(+), 20 deletions(-)

Thanks! The patch has been pushed upstream.

Johan
