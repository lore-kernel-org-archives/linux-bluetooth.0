Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <BN7PR07MB4305C4EE248EACC3F5F262889D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
References: <BN7PR07MB4305C4EE248EACC3F5F262889D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Aug 2018 09:11:46 +0300
Message-ID: <CABBYNZLJz7bq9165mgS4K7WY5jzGSC5rTxOD9_oUmxqs0KiPag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] Update the Adapter1 API to match the change to ConnectDevice
To: "Karabin, Josh" <George.Karabin@honeywell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

On Thu, Aug 16, 2018 at 11:29 PM, Karabin, Josh
<George.Karabin@honeywell.com> wrote:
> ---
>  doc/adapter-api.txt | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 2afd61bc3..918153f68 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -158,11 +158,11 @@ Methods           void StartDiscovery()
>                         similar to Connect method from Device1 interface with
>                         exception that this method returns success when physical
>                         connection is established. After this method returns,
> -                       services discovery will continue and any supported
> -                       profile will be connected. There is no need for calling
> -                       Connect on Device1 after this call. If connection was
> -                       successful this method returns object path to created
> -                       device object.
> +                       services discovery will continue.
> +
> +                       There is no need for calling Connect on Device1 after
> +                       this call. If connection was successful this method
> +                       returns object path to created device object.
>
>                         Parameters that may be set in the filter dictionary
>                         include the following:
> @@ -189,6 +189,11 @@ Methods            void StartDiscovery()
>                                          org.bluez.Error.NotReady
>                                          org.bluez.Error.Failed
>
> +               boolean ConnectAllProfiles
> +
> +                       If set to true, any supported profile will be
> +                       connected. This parameter is optional.

Id keep the original behaviour and just disable with AutoConnect which
by default, actually since this is an option usually we don't use
camelcase so instead it should be auto-connect.

> +
>  Properties     string Address [readonly]
>
>                         The Bluetooth device address.
> --
> 2.17.1
>



-- 
Luiz Augusto von Dentz
