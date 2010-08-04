Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Aug 2010 17:08:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 4/7] Support for adding UUID128 to extended inquiry
 response
Message-ID: <20100804140837.GB14996@jh-x301>
References: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
 <1280880237-2296-5-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280880237-2296-5-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Tue, Aug 03, 2010, Inga Stotland wrote:
> -		ptr[1] = (truncated) ? EIR_UUID16_SOME : EIR_UUID16_ALL;
> +		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;

And here's the fix I mentioned in the previous email that shouldn't be
needed to begin with.

Johan
