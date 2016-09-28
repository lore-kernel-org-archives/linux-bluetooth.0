Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APZxiSXDUzuHO_O2ir1A7LuGyTXSD3xoRWDaC6JDSKMmjQ@mail.gmail.com>
References: <CAAu3APZxiSXDUzuHO_O2ir1A7LuGyTXSD3xoRWDaC6JDSKMmjQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Sep 2016 13:55:57 +0300
Message-ID: <CABBYNZ+zVj4cAvn_J3f5w0gDdj_z4S=B4=WAW_P0krdO2vUqzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] doc/gatt-api.txt: Correct spelling mistakes
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

On Tue, Sep 27, 2016 at 12:39 AM, Barry Byford <31baz66@gmail.com> wrote:
> Correct small spelling errors
>
> ---
>
>  doc/gatt-api.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index fd4bdd5..1864391 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -115,7 +115,7 @@ Properties string UUID [read-only]
>
>   object Service [read-only]
>
> - Object path of the GATT service the characteristc
> + Object path of the GATT service the characteristic
>   belongs to.
>
>   array{byte} Value [read-only, optional]
> @@ -198,7 +198,7 @@ Properties string UUID [read-only]
>
>   object Characteristic [read-only]
>
> - Object path of the GATT characteristc the descriptor
> + Object path of the GATT characteristic the descriptor
>   belongs to.
>
>   array{byte} Value [read-only, optional]
> @@ -222,7 +222,7 @@ Properties string UUID [read-only]
>   "secure-read" (Server Only)
>   "secure-write" (Server Only)
>
> -GATT Profile hierarcy
> +GATT Profile hierarchy
>  =====================
>
>  Local profile (GATT client) instance. By registering this type of object
>
> --
> 2.5.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
