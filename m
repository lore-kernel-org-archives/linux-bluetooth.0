Return-Path: <cyrus@holtmann.org>
Message-ID: <1332935216.1870.165.camel@aeonflux>
Subject: Re: [PATCH] Use correct flags for checking HCI_SSP_ENABLED bit
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Date: Wed, 28 Mar 2012 13:46:56 +0200
In-Reply-To: <1332934749-12765-1-git-send-email-hemant.gupta@stericsson.com>
References: <1332934749-12765-1-git-send-email-hemant.gupta@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> This patch uses the correct flags for checking the HCI_SSP_ENABLED bit.
> Without this authentication request was not being initiated.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


