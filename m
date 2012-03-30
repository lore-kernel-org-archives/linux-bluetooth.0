Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 15:16:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Bluetooth: Send correct address type for LTK
Message-ID: <20120330121629.GA3615@x220>
References: <1333108415-12504-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333108415-12504-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Fri, Mar 30, 2012, Hemant Gupta wrote:
> This patch updates the address type sent from kernel to
> management interface of BlueZ while sending the Long Term
> Key.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
