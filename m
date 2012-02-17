Return-Path: <cyrus@holtmann.org>
Message-ID: <1329467624.28848.124.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: mgmt: Use more consistent error variable
 names
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:33:44 +0100
In-Reply-To: <1329434578-5928-4-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
	 <1329434578-5928-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For simple integer errors the variable name "err" is more consistent
> with the existing code base than "ret".
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


