Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 11:49:28 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH] hfp: gateway_suspend_stream should trigger a state
 change
Message-ID: <20110211194928.GA22785@jh-x301>
References: <1297334461-23077-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297334461-23077-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Feb 10, 2011, Daniel Wagner wrote:
> When gateway_suspend_stream is called it should change the
> gateway state machine from PLAYING to CONNECTED.
> ---
>  audio/gateway.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
