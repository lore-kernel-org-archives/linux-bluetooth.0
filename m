Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jan 2012 22:44:31 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix mgmt_stop_discovery_failed()
Message-ID: <20120103004431.GE1472@joana>
References: <1325533853-10101-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325533853-10101-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2012-01-02 16:50:53 -0300]:

> Stop Discovery Command Status Event should use mgmt status code.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
