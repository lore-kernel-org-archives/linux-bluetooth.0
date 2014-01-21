Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@tieto.com>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/5] android/bluetooth: Use defines for settings and devices files paths
Date: Tue, 21 Jan 2014 18:41:44 +0100
Message-ID: <1699475.kPZvhNixD9@athlon>
In-Reply-To: <2F525C49-B02B-4A87-8CAE-633BF53A8ADF@holtmann.org>
References: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com> <1390316497-18451-3-git-send-email-szymon.janc@tieto.com> <2F525C49-B02B-4A87-8CAE-633BF53A8ADF@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tuesday 21 January 2014 08:54:35 Marcel Holtmann wrote:
> Hi Szymon,
>=20
> > ---
> > android/bluetooth.c | 24 +++++++++++-------------
> > 1 file changed, 11 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/android/bluetooth.c b/android/bluetooth.c
> > index 8f08122..3314267 100644
> > --- a/android/bluetooth.c
> > +++ b/android/bluetooth.c
> > @@ -54,6 +54,9 @@
> >=20
> > #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
> >=20
> > +#define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
> > +#define DEVICES_FILE ANDROID_STORAGEDIR"/devices=E2=80=9D
>=20
> is there any good reason to keep cached devices together with the bon=
ded
> devices? I get the feeling a cached device should be safe to throw aw=
ay. So
> deleting the cache file should not cause any problems. Meaning it sho=
uld be
> a separate file.

I'm fine with having separate files too (even have this implemented on =
my=20
local branch), but wanted to avoid handling multiple files. Anyway, add=
/remove=20
bond doesn't happen that often so maybe this is not a problem.

So, is "device_cache" name OK? Or just "cache"?

--=20
Szymon K. Janc
szymon.janc@gmail.com
