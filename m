Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 11:12:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 2/6] Clean up code that generates extended inquiry
 response.
Message-ID: <20100803081258.GA5831@jh-x301>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
 <1280576713-1398-3-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280576713-1398-3-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Jul 31, 2010, Inga Stotland wrote:
> Minor fix when skipping duplicate UUID16 from EIR.
> ---
>  src/sdpd-service.c |   46 ++++++++++++++++++++++++++++++----------------
>  1 files changed, 30 insertions(+), 16 deletions(-)

So your commit message says two things: "Clean up code..." and "Minor
fix..". Cleanups and fixes should be in separate patches. Don't be
afraid of "too small" or trivial patches. As long as a patch contains a
single logically independent change it's fine.

Johan

> +	uint16_t uuid16[EIR_DATA_LENGTH/2];

Minor nitpick: space before and after /

Johan
