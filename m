Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next] bluetooth: 6lowpan: fix possible race
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438242053-15380-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 30 Jul 2015 14:12:21 +0200
Cc: jukka.rissanen@linux.intel.com,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, kernel@pengutronix.de
Message-Id: <2FA3BCC0-79B3-4003-894E-E5401AC2ADB9@holtmann.org>
References: <1438242053-15380-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> This patch fix a possible race after calling register_netdev. After
> calling netdev_register it could be possible that netdev_ops callbacks
> use the uninitialized private data of lowpan_dev. By moving the
> initialization of this data before netdev_register we can be sure that
> initialized private data is be used after netdev_register.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/bluetooth/6lowpan.c | 23 +++++++++++++----------
> 1 file changed, 13 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

