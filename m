Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Update L2CAP version after enable ERTM by
 default
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279949837-19944-1-git-send-email-gustavo@padovan.org>
References: <1279949837-19944-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 24 Jul 2010 06:47:10 -0700
Message-ID: <1279979230.2621.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Enable ERTM by default is a big change in the code, so changing the
> version here.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

actually no. We only increase the version number once per merge cycle
and I already have patch that does that.

Regards

Marcel


