Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <563A1880.8000608@convergeddevices.net>
References: <55D4834E.9080705@convergeddevices.net>
	<20150819162319.GA16000@t440s.P-661HNU-F1>
	<55E70CA1.1000308@convergeddevices.net>
	<563A1880.8000608@convergeddevices.net>
Date: Thu, 5 Nov 2015 11:12:48 +0200
Message-ID: <CABBYNZ+WMvoJxrrt59xx7r0thdLcJgfcBvYWN2_-QzCv+hzaHw@mail.gmail.com>
Subject: Re: BlueZ-5.36 segfault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: tony <tony.makkiel@convergeddevices.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

On Wed, Nov 4, 2015 at 4:38 PM, tony <tony.makkiel@convergeddevices.net> wrote:
> Hello,
>           I am getting a segfault within BlueZ-5.36.
>
> [ 8816.157843] bluetoothd[9264]: segfault at 2000000064 ip 00007fb2da31d216
> sp 00007ffc65426b48 error 4 in libc-2.19.so[7fb2da1dd000+1bb000].
>
> "deviceinfo_init" seems to be the cause of the problem. As 'external' flag
> is set for "deviceinfo_profile", one of the entry in
>
> GSList ext_profiles
>
> will be of type 'struct btd_profile'.
>
> Unfortunately later when "src/profile.c:register_profile" calls
> "find_ext_profile", g_strcmp0 tries to access "ext->owner" which does not
> exist for "deviceinfo" entry.


Are you sure it is really crashing in g_strcmp0, it is supposed to
handle NULL pointers and in fact it was introduced to fix this
problem. Can you try to provide a backtrace, perhaps something else
needs fixing.

>         The problem was gone by removing external flag.
>
> --- a/profiles/deviceinfo/deviceinfo.c
> +++ b/profiles/deviceinfo/deviceinfo.c
> @@ -142,7 +142,6 @@ static int deviceinfo_driver_accept(struct btd_service
> *service)
>  static struct btd_profile deviceinfo_profile = {
>         .name           = "deviceinfo",
>         .remote_uuid    = DEVICE_INFORMATION_UUID,
> -       .external       = true,
>         .device_probe   = deviceinfo_driver_probe,
>         .device_remove  = deviceinfo_driver_remove,
>         .accept         = deviceinfo_driver_accept,
>
> Many Thanks,
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
