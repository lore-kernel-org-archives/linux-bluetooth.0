Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422344977-26683-1-git-send-email-jsitnicki@gmail.com>
References: <1422344977-26683-1-git-send-email-jsitnicki@gmail.com>
Date: Tue, 27 Jan 2015 15:40:12 +0200
Message-ID: <CABBYNZJxySFEuNJP_nU_0peC0B0=hGHQcQzWzFeBpNQug7JRMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/device-api: Update possible errors for ConnectProfile
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Sitnicki <jsitnicki@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Jan 27, 2015 at 9:49 AM, Jakub Sitnicki <jsitnicki@gmail.com> wrote:
> Make API documentation reflect the current implementation.
> ---
>  doc/device-api.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 86d8af8..4f5e1d9 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -46,9 +46,11 @@ Methods              void Connect()
>                         device. The UUID provided is the remote service
>                         UUID for the profile.
>
> -                       Possible errors: org.bluez.Error.DoesNotExist
> -                                        org.bluez.Error.AlreadyConnected
> -                                        org.bluez.Error.ConnectFailed
> +                       Possible errors: org.bluez.Error.Failed
> +                                        org.bluez.Error.InProgress
> +                                        org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.NotAvailable
> +                                        org.bluez.Error.NotReady
>
>                 void DisconnectProfile(string uuid)
>
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
