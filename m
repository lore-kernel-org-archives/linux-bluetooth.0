Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jul 2010 11:20:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org
Subject: Re: [PATCH v4 0/5] Enhanced support for extended inquiry response
Message-ID: <20100723082045.GA1600@jh-x301>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Thu, Jul 22, 2010, Inga Stotland wrote:
> EIR is updated whenever local SDP record database changes.

Could you explain to me why this is needed. With the current git
(without your patches) the local EIR data seems to be correctly updated
whenever the SDP database changes. Are there some scenarios when this
doesn't happen? I did a quick test with sdptool add/del while bluetoothd
was running and I could see the appropriate "Write Extended Inquiry
Response" commands with hcidump.

Johan
