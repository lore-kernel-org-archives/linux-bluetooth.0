Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298468980-2215-1-git-send-email-epx@signove.com>
References: <1298468980-2215-1-git-send-email-epx@signove.com>
Date: Thu, 24 Feb 2011 15:29:22 -0300
Message-ID: <AANLkTik9wa_Pzezs3_udVD9MzwjxOaAAdEugjrD_U-KG@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] Add generic descriptor support to Attribute API document
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Wed, Feb 23, 2011 at 10:49 AM, Elvis Pfützenreuter <epx@signove.com> wrote:
> This patch proposes extensions to Attribute API, giving access to all
> characteristic descriptors (beyond 'Description' and 'Format').
>
> Client Characteristic Configuration automatic update upon Watcher
> registering will be handled by another patch series.
> ---
>  doc/attribute-api.txt |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
> index 23808e6..bb7cbfa 100644
> --- a/doc/attribute-api.txt
> +++ b/doc/attribute-api.txt
> @@ -104,6 +104,7 @@ Methods             dict GetProperties()
>
>                        Possible Errors: org.bluez.Error.InvalidArguments
>
> +
>  Properties     string UUID [readonly]
>
>                        UUID128 of this characteristic.
> @@ -143,6 +144,35 @@ Properties         string UUID [readonly]
>                        Friendly representation of the Characteristic Value
>                        based on the format attribute.
>
> +               dict Descriptors [readwrite]
> +
> +                       Dict of descriptors for this characteristic.
> +
> +                       This dict contains only the descriptors not already
> +                       covered by other properties (v.g. Description, Format).
> +
> +                       Each descriptor is mapped to an unique object path,
> +                       which is the dict key.
> +
> +                       Each dict value is, in turn, a dict with at least
> +                       the following keys:
> +
> +                       {
> +                               "UUID": string. Descriptor UUID, always present
> +                               "Value": array of bytes. Raw descriptor value,
> +                                        present only when/if descriptor value
> +                                        has been fetched.
> +                       }
> +
> +                       When updating a descriptor value using SetProperty(),
> +                       only one descriptor at a time may be updated in order
> +                       to guarantee unambiguous error reporting. In other
> +                       words, when calling SetProperty('Descriptors', dict),
> +                       dict must have exactly one entry.
> +
> +                       Descriptor's UUID may not be updated. If present, it is
> +                       ignored by SetProperty().

With all those restrictions for writing, do you think it makes sense
to allow writing to the "Descriptors" property? Can you mention
situations where you might want applications to modify descriptors?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
