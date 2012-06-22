Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4FE44DAD.90004@ruff.mobi>
References: <4FE44DAD.90004@ruff.mobi>
Date: Fri, 22 Jun 2012 23:34:58 +0300
Message-ID: <CABBYNZLKfMYfuk=N2qwh4skzffM5PT5hu5HXCPiZOZiAgdj=Eg@mail.gmail.com>
Subject: Re: [PATCH] pcm_bluetooth: accept BT_A2DP_SBC_SOURCE codec
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ruslan N. Marchenko" <me@ruff.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Fri, Jun 22, 2012 at 1:49 PM, Ruslan N. Marchenko <me@ruff.mobi> wrote:
> Current implementation of the PCM code is considering capture (source) mode
> however it ignores codecs of the SBC_SOURCE type while parsing capabilities.
> With these two lines source codec is accepted, although proper capture mode
> might require additional changes.
>
> Signed-off-by: Ruslan N. Marchenko <me@ruff.mobi>
> ---
>  audio/pcm_bluetooth.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

We are about to remove alsa support from BlueZ as it doesn't support
the Media API, so this is a nak

Please next time use git format-patch + git send-email so it is easier
to us to apply the patch using git am, also there is no need for the
signed-off-by for userspace patches.


-- 
Luiz Augusto von Dentz
