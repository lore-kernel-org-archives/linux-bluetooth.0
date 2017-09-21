Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170920074417.30435-1-luiz.dentz@gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Sep 2017 10:49:10 +0300
Message-ID: <CABBYNZJTYWfm6BWOTBt4i2XDbKmg_4TW936gUpFCMSvugTE58Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] gatt: Add server support for AcquireWrite and AcquireNotify
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Jonah Petri <jonah@sense.com>, Yunhan Wang <yunhanw@nestlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 20, 2017 at 10:44 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This implements similar mechanist to use dedicated file descriptors
> for IO bypassing D-Bus.
>
> Note: The current implementation opens just one fd per characteristic,
> though it could be possible to have one fd per device.
>
> v2: Allow any type of write procedure to work when WriteAcquired exists.
>
> Luiz Augusto von Dentz (10):
>   gatt: Remove useless debug
>   client: Rework variables for AcquireWrite/AcquireNotify
>   doc/gatt-api: Add server support for AcquireWrite and AcquireNotify
>   shared/gatt-server: Add bt_gatt_server_get_mtu
>   shared/gatt-db: Add gatt_db_attribute_get_user_data
>   gatt: Implement AcquireWrite for server
>   client: Implement AcquireWrite for server
>   gatt: Implement AcquireNotify for server
>   client: Implement AcquireNotify for server
>   gatt: Update signature of AcquireWrite and AcquireNotify
>
>  client/gatt.c            | 319 ++++++++++++++++++++++++++++++++++++++++-------
>  doc/gatt-api.txt         |  36 ++++--
>  mesh/gatt.c              |  23 +++-
>  src/gatt-client.c        |   8 +-
>  src/gatt-database.c      | 258 +++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-db.c     |   8 ++
>  src/shared/gatt-db.h     |   2 +
>  src/shared/gatt-server.c |   8 ++
>  src/shared/gatt-server.h |   1 +
>  9 files changed, 598 insertions(+), 65 deletions(-)
>
> --
> 2.13.5

Any other feedback on this? Does it address all the use cases you guys
have been struggling?


-- 
Luiz Augusto von Dentz
