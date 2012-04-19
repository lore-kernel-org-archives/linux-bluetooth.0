Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 11:16:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Don't distribute keys in case of
 Encryption Failure
Message-ID: <20120419141648.GB4127@joana>
References: <1334740586-22347-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334740586-22347-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

* Hemant Gupta <hemant.gupta@stericsson.com> [2012-04-18 14:46:26 +0530]:

> SMP Keys should only be distributeed when encryption is successful.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
