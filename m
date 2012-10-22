Return-Path: <cyrus@holtmann.org>
Message-ID: <1350925243.1785.24.camel@aeonflux>
Subject: Re: [PATCH RESEND net-next] bluetooth: hci_core: Replace
 list_for_each with list_for_each_entry() helper
From: Marcel Holtmann <marcel@holtmann.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Oct 2012 10:00:43 -0700
In-Reply-To: <1350912121-24171-1-git-send-email-kirjanov@gmail.com>
References: <1350912121-24171-1-git-send-email-kirjanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

> Replace list_for_each with list_for_each_entry() helper
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |   20 ++++++++------------
>  1 files changed, 8 insertions(+), 12 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


