Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330094132-11762-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1330094132-11762-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 24 Feb 2012 14:35:27 -0200
Message-ID: <CAA37ika33Gt0QJARhGRZrGc5NwfCtPnKNQXQVr8JodynMZ0F5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix double locking in LE and conless chan
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Feb 24, 2012 at 12:35 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Remove socket lock since chan->ops->recv locks socket itself.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)

Looks good. Please remember to test these paths too when making
changes that touch whole L2CAP core.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
