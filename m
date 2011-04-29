Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304030070-6575-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
	<1304030070-6575-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 29 Apr 2011 14:27:48 +0300
Message-ID: <BANLkTimm=CVbBrLEPWf8Q0BgvtMmZaxNBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Remove wrong checking for legacy devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Apr 29, 2011 at 1:34 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Infer that the found device is a legacy device based on the presence
> of its name in the storage is wrong.
> ---
>  src/event.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/src/event.c b/src/event.c
> index 5373e33..b873000 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -481,8 +481,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>
>        if (data)
>                legacy = FALSE;
> -       else if (name == NULL)
> -               legacy = TRUE;
>        else if (read_remote_features(local, peer, NULL, features) == 0) {
>                if (features[0] & 0x01)
>                        legacy = FALSE;
> --

That was some use of it, but I can't remember now, maybe some broken
stack which has feature bits broken or we do actually infer if we ever
connect to the device before trying to read its features from the
storage.


-- 
Luiz Augusto von Dentz
Computer Engineer
