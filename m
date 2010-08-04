Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Aug 2010 17:07:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/7] Clean up code that generates extended inquiry
 response.
Message-ID: <20100804140720.GA14996@jh-x301>
References: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
 <1280880237-2296-4-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280880237-2296-4-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

The patches are starting to look pretty good. A couple more coding style
issues though (in this and a few consequtive emails):

On Tue, Aug 03, 2010, Inga Stotland wrote:
> +		ptr[1] = (truncated) ? EIR_UUID16_SOME : EIR_UUID16_ALL;

Another patch in your patch set "fixes" this and removes the parenthesis
around truncated. Could you just fix it in this patch itself. In general
patches with fixes to other patches that aren't yet upstream should be
avoided by redoing the the first patch that caused the need for a fix to
begin with.

Johan
