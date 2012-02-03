Return-Path: <cyrus@holtmann.org>
Message-ID: <1328288529.2062.43.camel@aeonflux>
Subject: Re: [PATCHv1 2/2] Bluetooth: Helper removes duplicated code
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 09:02:09 -0800
In-Reply-To: <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use __check_timout helper to remove duplicated code
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   31 +++++++++++++------------------
>  1 files changed, 13 insertions(+), 18 deletions(-)

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>
Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


