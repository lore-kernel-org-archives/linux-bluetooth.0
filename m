Return-Path: <cyrus@holtmann.org>
Message-ID: <1351170581.1785.91.camel@aeonflux>
Subject: Re: [RFCv1 11/11] Bluetooth: AMP: Check for hs_hcon instead of
 ctrl_id
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Oct 2012 06:09:41 -0700
In-Reply-To: <1351167652-12346-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351167652-12346-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When deciding whether to send EFS configuration response with success,
> check rather for existence of High Speed physical link hs_hcon then
> ctrl_id. There might be cases when there is ctrl_id but high speed link
> is not established yet.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


