Return-Path: <cyrus@holtmann.org>
Message-ID: <1351170551.1785.90.camel@aeonflux>
Subject: Re: [RFCv1 10/11] Bluetooth: Add put(hcon) when deleting hchan
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Oct 2012 06:09:11 -0700
In-Reply-To: <1351167652-12346-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351167652-12346-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> When refcnt reaches zero disconnect timeout will run and hci_conn
> will be disconnected.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


