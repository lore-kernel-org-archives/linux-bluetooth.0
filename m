Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1430140475-20349-6-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
	<1430140475-20349-6-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 27 Apr 2015 13:21:07 -0700
Message-ID: <CAHrH25THrdR3QKVa79hZqxeBnnz-Z62STy_TmHnhvi7UuqscHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/8] doc/gatt-api: Add Flags property to GattDescriptor
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Mon, Apr 27, 2015 at 6:14 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds Flags property to GattDescriptor so the server can define
> permissions and authentication requirements for descriptors.
> ---
>  doc/gatt-api.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 8db35f2..8459430 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -210,6 +210,20 @@ Properties string UUID [read-only]
>                         gets updated only after a successful read request, upon
>                         which a PropertiesChanged signal will be emitted.
>
> +               array{string} Flags [read-only]
> +
> +                       Defines how the descriptor value can be used.
> +
> +                       Possible values:
> +
> +                               "read"
> +                               "write-without-response"
> +                               "write"
> +                               "authenticated-signed-writes"

These 4 above are defined as characteristic properties in the CS, so
I'm not sure why they would be in a descriptor. The point of these
properties (as defined by the Core Spec) is not to communicate
attribute permissions but to tell the remote end what procedures a
characteristic supports in general. So there's no point of including
these in the descriptor as there is no way to communicate these over
ATT (whereas these are returned in a characteristic declaration and
extended properties descriptor value for characteristics). So maybe
just keep read/write for the basic permissions.

> +                               "encrypt-read"
> +                               "encrypt-write"
> +                               "encrypt-authenticated-read"
> +                               "encrypt-authenticated-write"
>
>  Profile hierarcy
>  ================
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
