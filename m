Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gatt: Fix NULL pointer dereference on destroy
Date: Wed, 16 Jul 2014 17:53:22 +0200
Message-ID: <8174973.ezf6VjRdXk@uw000953>
In-Reply-To: <1405513050-10779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405513050-10779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 16 of July 2014 15:17:30 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This patch adds pointer check to gatt_db_destroy allowing user to call
> it with NULL pointer. This follow convention used in shared code for
> destroy functions. This fix following android bluetoothd crash in a case
> crypto failed to initialize.
> 
> ...
> I/ProbeModule(24651): insmod_by_dep: parse base black list error -1
> E/ProbeModule(24651): insmod_by_dep: cannot find module's dependency
> info: [net-pf-38]
> I/bluetoothd(24639): bluetoothd[24640]: gatt: Failed to setup crypto
> ...
> I/DEBUG   (16237): *** *** *** *** *** *** *** *** *** *** *** *** ***
> *** *** ***
> I/DEBUG   (16237): Build fingerprint:
> 'Intel/hsb/hsb:4.4.2/KOT49H/eng.android.20140514.123328:eng/test-keys'
> I/DEBUG   (16237): Revision: '0'
> I/DEBUG   (16237): pid: 24640, tid: 24640, name: bluetoothd-main  >>>
> /system/bin/bluetoothd-main <<<
> I/DEBUG   (16237): signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr
> 00000004
> ...
> I/DEBUG   (16237): stack:
> I/DEBUG   (16237):          ff81a9dc  ff81aa14  [stack]
> I/DEBUG   (16237):          ff81a9e0  00000000
> I/DEBUG   (16237):          ff81a9e4  f75c2e06  /system/lib/libc.so
> (vsyslog+6)
> I/DEBUG   (16237):          ff81a9e8  f77c0cd8
> /system/bin/bluetoothd-main
> I/DEBUG   (16237):          ff81a9ec  f778692c
> /system/bin/bluetoothd-main (gatt_db_destroy+12)
> I/DEBUG   (16237):     #00  ff81a9f0  00000003
> I/DEBUG   (16237):          ff81a9f4  f77865c0
> /system/bin/bluetoothd-main (gatt_db_service_destroy)
> I/DEBUG   (16237):          ff81a9f8  f7784709
> ...
> ---
>  src/shared/gatt-db.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index f671480..b3f95d2 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -138,6 +138,9 @@ static void gatt_db_service_destroy(void *data)
>  
>  void gatt_db_destroy(struct gatt_db *db)
>  {
> +	if (!db)
> +		return;
> +
>  	queue_destroy(db->services, gatt_db_service_destroy);
>  	free(db);
>  }
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
