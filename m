Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 18:34:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH v1] Bluetooth: mgmt: Fix missing connect failed event for
 LE
Message-ID: <20120405153423.GA4102@x220.P-661HNU-F1>
References: <1333624864-15720-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333624864-15720-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Thu, Apr 05, 2012, Hemant Gupta wrote:
> This patch adds management connect failed event when LE Create Connection
> Command fails to inform user space that LE Connection failed to get
> established.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/hci_event.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
