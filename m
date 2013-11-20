Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Nov 2013 09:42:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-pan: Fix order of event handler registration
Message-ID: <20131120074216.GB12279@x220.p-661hnu-f1>
References: <1384896258-12789-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384896258-12789-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 19, 2013, Ravi kumar Veeramally wrote:
> IPC message handler determines handler offset with
> opcode = msg->opcode - HAL_MINIMUM_EVENT. But here order is misplaced.
> ---
>  android/hal-pan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
