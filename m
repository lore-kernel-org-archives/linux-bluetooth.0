Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <86D12A3EE8C39046AB3F026D471074661D244170@POCITMSEXMB02.LntUniverse.com>
References: <86D12A3EE8C39046AB3F026D471074661D244170@POCITMSEXMB02.LntUniverse.com>
Date: Mon, 30 Jun 2014 17:11:50 +0300
Message-ID: <CABBYNZLpSJ86b9O1w=XqZDJBwZ6zxz1qA_b2-XC_G20XiDX+Gw@mail.gmail.com>
Subject: Re: Query on BLE profile contribution
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Amith Raghunath <Amith.Raghunath@lnttechservices.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, Wins Thomas <Wins.Thomas@lnttechservices.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 30, 2014 at 12:26 PM, Amith Raghunath
<Amith.Raghunath@lnttechservices.com> wrote:
> Hi Marcel/John,
>     We are planning to contribute a BLE Findme profile for the "Locator Role" to the Bluez Stack.
>     It is around 300 lines of code (excluding comments & blank lines).
>     We request your kind self to let us know the following:
>            a)  Approximate time that it would take for this code to get reviewed.
>            b)  The procedure to add this file to the Bluez GIT

The guidelines are about the same for kernel and userspace, so you are
suppose to provide a with proper git patches (git format-patch + git
send-email). Regarding the profile itself I would probably hold on to
use the new infrastructure from bt_gatt or do as we did with BAS, DIS
and HoG in android where we use GAttrib only internally.

I would probably suggest creating LGPL helpers under src/shared/
before the implementing any plugin, e.g.:

- bt_<profile>_new(primary): Allocate the data structures
- bt_<profile>_attach(instance, connection): On the first attach you
are suppose to discover the handles and cache them, once the handle
are cached then you can proceed with notification and read/write
operations required by the profile.
- bt_<profile>_detach(instance): Unref any connection reference and
cleanup any notification etc.
- bt_<profile>_set_notification(instance, callback, data): This is
optional in case the profile does provide notifications.
- bt_<profile>_unref: Detach and free the data structures

-- 
Luiz Augusto von Dentz
