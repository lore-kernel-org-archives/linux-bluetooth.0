Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Android 7.0 not discovering LE services
From: Wilson <griscruf@comcast.net>
In-Reply-To: <CABBYNZ+N-+f2dQigQH-voeRCHLM72sHHbp+bVOcgABR_5nyeSg@mail.gmail.com>
Date: Fri, 16 Sep 2016 16:14:42 -0400
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <53809D80-80D6-4B57-AC90-349A9AE13AC9@comcast.net>
References: <6874A094-FC92-47DD-B624-3CADAE801D27@comcast.net> <CABBYNZ+N-+f2dQigQH-voeRCHLM72sHHbp+bVOcgABR_5nyeSg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sep 16, 2016, at 8:05 AM, Luiz Augusto von Dentz =
<luiz.dentz@gmail.com> wrote:

>> I'm running nRF Connect on the Android devices.  I captured (latest) =
bluetoothd and btmon logs for both cases:
>>=20
>> Android6 bluetoothd: https://paste.gnome.org/pfkliqrqw
>> Android6 btmon:        https://paste.gnome.org/pcyxvla79
>>=20
>> Android7 bluetoothd: https://paste.gnome.org/pk4qj6wp8
>> Android7 btmon:        https://paste.gnome.org/p5e4fgoua
>=20
> Both seems to be connecting over BR/EDR and only finding GAP and GATT
> primary service so I wonder if you do have anything else registered
> there?

Thanks for that clue about BR/EDR.  I tried a different Android BLE app =
and didnt see that problem.  In my original test which found the Android =
7 problem, I was running bluez-5.37 with some of your patches from =
January for GDBus.  I just upgraded to 5.41 and it appears to be working =
in my Ubuntu test.  I have to do some testing with embedded hardware, =
but I think the upgrade will do the trick. =20

Thanks again, Wilson=
