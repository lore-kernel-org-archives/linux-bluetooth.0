Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHU4CUJxjE=7J6KybKcxqBo6MGvA4+g5-6b+ktwSM82B_r9BDA@mail.gmail.com>
References: <CAHU4CUJxjE=7J6KybKcxqBo6MGvA4+g5-6b+ktwSM82B_r9BDA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2018 19:25:22 -0200
Message-ID: <CABBYNZKeWT+vXc-o3tDkMJbeZJRdz2Qx6WOc-mDU2RX6Z3o0VQ@mail.gmail.com>
Subject: Re: Pairing when already paired results in a hang
To: Ahmed Alsharif <ahmeds2000x@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ahmed,

On Tue, Jan 2, 2018 at 7:49 PM, Ahmed Alsharif <ahmeds2000x@gmail.com> wrote:
> Hey,
>
> I've noticed that when using the Pair() method on a device already
> paired, it hangs indefinitely (never returns a reply), or potentially
> returns an AuthenticationCancelled error, when the device disappears.
> The comments in the pair_device(...) function say something about an
> SMP bug, and the comments in adapter_bonding_attempt(...) also mention
> a bug about some LE pairing requests never timing out.
> I'm not really sure if the behavior I mentioned has something to do
> with the bug/bugs from the comments or not, so I'm wondering if
> there's a reason for not checking if the device is paired already or
> not, before proceeding with the pairing?
>
> The following patch stops the indefinite hang for me on second pairing
> attempts, and still achieves the side effects of pairing, e.g.
> connecting. I'm not 100% sure however that this isn't causing
> different problems.
>
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2490,6 +2490,11 @@ static DBusMessage *pair_device(DBusConnection
> *conn, DBusMessage *msg,
>         if (state->bonded)
>                 return btd_error_already_exists(msg);
>
> +       if (state->paired) {
> +               device->bredr_state.paired = false;
> +               device->le_state.paired = false;
> +       }
> +

Id say it is not a good idea to invalidate the current pairing upfront
as the remote could be offline this could cause some side effects,
besides we would need to clear the storage as well, perhaps the
current logic is to try the new pairing first but there could be
something preventing the new pairing to happen if it already exists so
we need to check if there is a new pairing ongoing.


-- 
Luiz Augusto von Dentz
