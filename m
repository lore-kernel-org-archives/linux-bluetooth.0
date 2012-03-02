Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
References: <1330641157-32626-1-git-send-email-marcel@holtmann.org>
Date: Thu, 1 Mar 2012 20:23:50 -0400
Message-ID: <CAJdJm_PHQOfstiuUfMfgtceWN=Ko37COLQNKkXb12Gc3CEOchw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update MGMT and SMP timeout constants to use msecs_to_jiffies
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Mar 1, 2012 at 6:32 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> The MGMT and SMP timeout constants are always used in form of jiffies. So
> just include the conversion from msecs in the define itself. This has the
> advantage of making the code where the timeout is used more readable.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> =A0net/bluetooth/mgmt.c | =A0 =A05 ++---
> =A0net/bluetooth/smp.c =A0| =A0 =A05 ++---
> =A02 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7bd7d57..40b3da3 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -116,7 +116,7 @@ static const u16 mgmt_events[] =3D {
> =A0#define INQUIRY_LEN_BREDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x08 =A0 =A0/* TG=
AP(100) */
> =A0#define INQUIRY_LEN_BREDR_LE =A0 =A0 =A0 =A0 =A0 0x04 =A0 =A0/* TGAP(1=
00)/2 */
>
> -#define SERVICE_CACHE_TIMEOUT (5 * 1000)
> +#define CACHE_TIMEOUT =A0msecs_to_jiffies(2 * 1000)

Was it intentional to change timeout from 5 seconds to 2 seconds on this co=
mmit?

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
