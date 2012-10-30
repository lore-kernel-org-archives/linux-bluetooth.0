Return-Path: <cyrus@holtmann.org>
Message-ID: <1351615596.1828.2.camel@aeonflux>
Subject: Re: [RFCv2 02/12] Bluetooth: Save hs_hchan instead of hs_hcon in
 loglink complete
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 30 Oct 2012 09:46:36 -0700
In-Reply-To: <1351612384-12392-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351612384-12392-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When logical link creation is completed we need to save hs_hchan
> which represents logical link instead of hs_hcon representing
> physical link. hs_hcon shall be saved when receiving physical link
> complete event.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


