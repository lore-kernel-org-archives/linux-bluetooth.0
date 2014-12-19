Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418952279-16452-1-git-send-email-armansito@chromium.org>
References: <1418952279-16452-1-git-send-email-armansito@chromium.org>
Date: Fri, 19 Dec 2014 19:00:25 -0200
Message-ID: <CABBYNZKYA_t48rPVQ-WJ1AKKgixN1LJXCtrCmAZt+_ci_+mdjQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 0/7] core: Use shared/gatt-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Dec 18, 2014 at 11:24 PM, Arman Uguray <armansito@chromium.org> wrote:
> *v5:
>   - Made probing a bit smarter, so that profiles are only probed once when
>     necessary and they are removed if they no longer valid after non-bonded
>     discovery.
>
> *v4:
>   - Removed gatt-callbacks in favor of using btd_profile probe and remove
>     functions. Added the new btd_profile function "accept" to notify profiles
>     that gatt-client is ready.
>
>   - Using device_remove_profile to unregister btd_service's when services are
>     removed from the client database. This happens on Service Changed events and
>     on disconnection if the device is not bonded.
>
>   - Removed immediated disconnection logic that triggers when no attio callbacks
>     are registered after probe.
>
>   - Other minor fixes to shared/gatt and shared/att.
>
> *v3:
>   - Renamed device_attach_att_transport to device_attach_att.
>
> *v2:
>   - Rebased.
>
> *v1:
>   - Addressed comments by Johan and Luiz.
>
> Arman Uguray (7):
>   core: device: Don't disconnect if attios not set
>   core: device: Add getters for GATT db and client
>   core: device: Make profile calls in GATT events
>   profiles/gatt: Don't handle GATT service.
>   profiles/gatt: Rename profile to gap.
>   profiles/gap: Rewrite using bt_gatt_client.
>   profiles/gap: Add Google copyright.
>
>  Makefile.plugins    |   4 +-
>  profiles/gap/gas.c  | 339 ++++++++++++++++++++++++++++++++++++++
>  profiles/gatt/gas.c | 457 ----------------------------------------------------
>  src/device.c        | 390 +++++++++++++++++++++++++++++++++++++-------
>  src/device.h        |   2 +
>  5 files changed, 676 insertions(+), 516 deletions(-)
>  create mode 100644 profiles/gap/gas.c
>  delete mode 100644 profiles/gatt/gas.c
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
