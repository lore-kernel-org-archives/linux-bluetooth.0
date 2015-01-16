Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421206267-26369-1-git-send-email-armansito@chromium.org>
References: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Date: Fri, 16 Jan 2015 16:21:19 +0200
Message-ID: <CABBYNZLmD_so_MpEwS0YY6MUT5_LuwvR9i=ooTZYWO04k-2wrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/8] Implement doc/gatt-api.txt for client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Jan 14, 2015 at 5:30 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v3:
>   - Fixed broken GATT service UUID management in its own patch.
>   - Other small fixes.
>
> Arman Uguray (8):
>   shared/gatt-db: Add service getter by UUID
>   core: device: Fix GATT profile probing
>   core: device: Fix broken GATT UUID management
>   profiles/gap: Fix probe/accept behavior.
>   core: service: Remove GATT handle logic
>   shared/gatt-db: Add "claimed" field to services
>   core: gatt: Use "claimed" instead of "active"
>   doc/gatt-api.txt: Update error names
>
>  doc/gatt-api.txt     |  12 +-
>  plugins/sixaxis.c    |   2 +-
>  profiles/gap/gas.c   | 127 +++++++------
>  src/adapter.c        |   8 +-
>  src/device.c         | 498 +++++++++++++++++++++++++++++----------------------
>  src/device.h         |   6 +-
>  src/gatt-client.c    |   9 +-
>  src/service.c        |  38 ----
>  src/service.h        |   7 -
>  src/shared/gatt-db.c |  46 +++++
>  src/shared/gatt-db.h |   7 +
>  11 files changed, 428 insertions(+), 332 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, note that I did exclude core: device: Fix broken GATT UUID
management and instead remove the code that deal with invalidating the
services, we have similar behavior for SDP. I found a problem with the
current code it does not exclude services properly once I restart
bluetoothd, most likely because we don't reload the services and once
we reconnect they are not updated since register_gatt_services is only
called if device->browse which is not the case while reconnecting.

Furthermore I would do some cleanup in the way the service are
registered, maybe move some code to src/gatt-client.c and Im also
thinking in creating the D-Bus objects as they are found so we don't
have different code paths creating them.


-- 
Luiz Augusto von Dentz
