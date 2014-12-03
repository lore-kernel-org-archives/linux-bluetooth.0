Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417635148-32546-1-git-send-email-armansito@chromium.org>
References: <1417635148-32546-1-git-send-email-armansito@chromium.org>
Date: Wed, 3 Dec 2014 23:29:20 +0200
Message-ID: <CABBYNZKeXhRmc0EfakBt2esYLvzoJprraZvBeFcFDHnhat6+tg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/4] shared/gatt-db: Add service events.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 3, 2014 at 9:32 PM, Arman Uguray <armansito@chromium.org> wrote:
> *v1:
>    - Removed in_notify/need_notify_cleanup logic, since shared/queue has
>      been fixed to correctly handle queue_remove during a call to
>      queue_foreach.
>
> This patch set introduces service added/removed events to gatt-db.
> gatt-db now allows callbacks to be registered, which are called when a
> service is marked as active/inactive or when they get removed from the
> database.
>
> Also included is a small fix to gatt-server so that it holds a reference
> to its associated gatt-db.
>
> Arman Uguray (4):
>   shared/gatt-server: Hold a reference to gatt-db.
>   shared/gatt-db: Add service added/removed events.
>   tools/btgatt-client: Observe service events.
>   TODO: gatt-db service events added.
>
>  TODO                     |   7 --
>  src/shared/gatt-db.c     | 168 ++++++++++++++++++++++++++++++++++++++++++-----
>  src/shared/gatt-db.h     |  39 ++++++-----
>  src/shared/gatt-server.c |   5 +-
>  tools/btgatt-client.c    |  28 ++++++++
>  5 files changed, 207 insertions(+), 40 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
