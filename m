Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Aug 2010 17:09:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH 5/7] Fix in logic to write EIR when SDP records are
 changed.
Message-ID: <20100804140949.GC14996@jh-x301>
References: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
 <1280880237-2296-6-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280880237-2296-6-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Tue, Aug 03, 2010, Inga Stotland wrote:
> +static void update_ext_inquiry_response(struct btd_adapter *adapter);

Is this forward declaration really necessary? Would it be possible to
get rid of it by rearranging the static functions in this file (i.e.
move update_ext_inquiry_response higher up in the file)?

Johan
