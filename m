Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429686894-29667-1-git-send-email-luiz.dentz@gmail.com>
References: <1429686894-29667-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2015 09:14:38 -0700
Message-ID: <CAHrH25TKR51pkSh_+-UpCsL=71t+-DxEfBmxtOMkJGJfvMf92w@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/gatt-api: Add encryption flag
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Wed, Apr 22, 2015 at 12:14 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This add encryption flag which can be used when registering a service to
> require encryption when accessing a characteristic.
> ---
>  doc/gatt-api.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 088d285..92118fd 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -148,6 +148,7 @@ Properties  string UUID [read-only]
>                                 "authenticated-signed-writes"
>                                 "reliable-write"
>                                 "writable-auxiliaries"
> +                               "encryption"
>
>                 array{object} Descriptors [read-only]
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I've actually been planning to send a patch to add a "Permissions"
property to GattCharacteristic1 and GattDescriptor1, which would be
more in line with GATT attribute permissions. What I had in mind was a
"Permissions" property, which would have array{string} as the type.
And potential values would be "read-encrypted", "read-authenticated",
etc. What do you think?

Thanks,
Arman
