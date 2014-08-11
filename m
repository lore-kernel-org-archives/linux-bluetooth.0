Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 4/4] mac802154: common tx error path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407756310-26592-5-git-send-email-alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 12:17:50 -0700
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
	kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>
Message-Id: <14AF6B17-8BF7-44BB-B455-BA63ED451C01@holtmann.org>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com> <1407756310-26592-5-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> From: Varka Bhadram <varkab@cdac.in>
> 
> This patch introduce the common error path on failure of Tx by
> inserting the label 'err_tx'.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/tx.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

