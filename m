Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetooth:hci_bcsp - Change 1 to true for bool type variables assignments.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432578657-4351-1-git-send-email-shailendra.capricorn@gmail.com>
Date: Mon, 25 May 2015 20:58:23 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ABAA00AD-D55C-402C-8289-992FFDB13207@holtmann.org>
References: <1432578657-4351-1-git-send-email-shailendra.capricorn@gmail.com>
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shailendra,

> The variables txcrc and hciextn are bool type.So assigning true 
> instead of 1.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
> drivers/bluetooth/hci_bcsp.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

