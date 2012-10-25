Return-Path: <cyrus@holtmann.org>
Message-ID: <1351170405.1785.87.camel@aeonflux>
Subject: Re: [RFCv1 01/11] Bluetooth: trivial: Remove unneeded assignment
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Oct 2012 06:06:45 -0700
In-Reply-To: <1351167652-12346-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351167652-12346-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Assignment is not needed here since err is always gets value.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


