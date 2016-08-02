Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <B54B2641-A4CF-4C92-BE25-4B72CBEC5355@starleaf.com>
References: <B54B2641-A4CF-4C92-BE25-4B72CBEC5355@starleaf.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Aug 2016 13:45:49 +0300
Message-ID: <CABBYNZKWsCs7aNUiT-p68Tb=gU5c=NMrTYHDQo655F97mb-ytQ@mail.gmail.com>
Subject: Re: LE Advertising API: supported options for RegisterAdvertisement
To: Alex Coplan <alex.coplan@starleaf.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Aug 1, 2016 at 10:41 PM, Alex Coplan <alex.coplan@starleaf.com> wrote:
> Hi all,
>
> The documentation for the D-Bus interface org.bluez.LEAdvertisingManager1 documents the method RegisterAdvertisement with the prototype:
>
> RegisterAdvertisement(object advertisement, dict options)
>
> but does not specify which options are supported. It would be great if this were documented; in particular, I would be interested to find how to change the advertising interval through this API.

This is because it is still open although we do have support for it in
the MGMT interface with the kernel:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n2570

> Any advice would be really appreciated.
>
> Regards,
> Alex--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
