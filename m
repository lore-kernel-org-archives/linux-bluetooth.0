Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/4] mac802154: common error path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407756310-26592-3-git-send-email-alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 12:18:04 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-wpan@vger.kernel.org, kernel@pengutronix.de,
	Varka Bhadram <varkab@cdac.in>
Message-Id: <7A093622-CCE7-42B3-97A9-26851E637674@holtmann.org>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com> <1407756310-26592-3-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> From: Varka Bhadram <varkab@cdac.in>
> 
> By introducing label fail, making the common error path for
> mac802154_llsec_decrypt() and packet type default case.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/wpan.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

