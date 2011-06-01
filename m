Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 15:10:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] telephony-ofono: fix features initialization
Message-ID: <20110601121052.GE26952@dell.ger.corp.intel.com>
References: <1306929040-425-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306929040-425-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jun 01, 2011, Luiz Augusto von Dentz wrote:
> Features should be ready before telephony_init return, otherwise the
> record might contain invalid features.
> ---
>  audio/telephony-ofono.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)

Pushed upstream. Thanks.

Johan
