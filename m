Return-Path: <cyrus@holtmann.org>
Message-ID: <1358627012.6505.0.camel@aeonflux>
Subject: Re: [PATCH] bluetooth: btmrvl_sdio: look for sd8688 firmware in
 proper location
From: Marcel Holtmann <marcel@holtmann.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Bing Zhao <bzhao@marvell.com>, Ben Hutchings <ben@decadent.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	libertas-dev@lists.infradead.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sat, 19 Jan 2013 12:23:32 -0800
In-Reply-To: <1358622064-782-1-git-send-email-lkundrak@v3.sk>
References: <1358495893.5510.0.camel@aeonflux>
	 <1358622064-782-1-git-send-email-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lubomir,

> The firmware images are shared with libertas_sdio WiFi chip and used to be in
> libertas/ subtree in linux-firmware. As btmrvl_sdio used to look into the
> linux-firmware root, it ended up being unsuccessful. Since the firmware files
> are not specific to the libertas hardware, they're being moved into mrvl/ now.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


