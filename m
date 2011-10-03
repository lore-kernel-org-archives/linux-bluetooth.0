Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
References: <1317653871-14689-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 3 Oct 2011 16:24:04 -0300
Message-ID: <CAMOw1v53jigz-ASB=XRDa756gR04+-CKu2umPHBanRjRC2BmsA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Fix regression when disconnecting AVRCP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 3, 2011 at 11:57 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This prevent to disconnect AVRCP when doing e.g. Audio.Disconnect
> ---
> =A0audio/avctp.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index e9b8e40..b8cb36e 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -1021,7 +1021,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, co=
nst bdaddr_t *dst)
>
> =A0void avctp_disconnect(struct avctp *session)
> =A0{
> - =A0 =A0 =A0 if (session->io)
> + =A0 =A0 =A0 if (!session->io)

At least in oFono we have a coding style rule to always compare
pointers to NULL. I even have an old patch in bluez/gdbus for this:
6e66423fe87441e3e61e5a325fde1515efa63ac5

Luiz, Johan, Marcel: wouldn't it be better if BlueZ used this rule,
too? (and put the rules somewhere like oFono does?)



Lucas De Marchi
