Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 2317/2317] Staging : bluetooth Trailing whitespaces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1437760246-12177-1-git-send-email-shraddha.6596@gmail.com>
Date: Thu, 30 Jul 2015 13:28:19 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <FC73D120-5380-4B18-A5A4-32A660E8D516@holtmann.org>
References: <1437760246-12177-1-git-send-email-shraddha.6596@gmail.com>
To: Shraddha Barke <shraddha.6596@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sharaddha,

> This patch removes trailing whitespaces in the file bfusb.c
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> ---
> drivers/bluetooth/bfusb.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

this is not a staging patch. The Bluetooth subsystem does not require staging. And PATCH 2371/2371? Please sort this out and create proper patches using git format-patch.

And please not introduce lines that exceed 80 characters when attempting to fix a coding style issue. Fixing one coding style issue and adding a new one is not helping.

Regards

Marcel

