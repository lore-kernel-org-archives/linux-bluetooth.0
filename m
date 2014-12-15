Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
References: <1418409864-26119-1-git-send-email-jamuraa@chromium.org>
Date: Mon, 15 Dec 2014 12:47:57 +0200
Message-ID: <CABBYNZLs3a8jZQcBZkT8Fnor2cJkERwRM9uGmWv-be0_BTaAGw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] foreach early termination
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Fri, Dec 12, 2014 at 8:44 PM, Michael Janssen <jamuraa@chromium.org> wrote:
> This patch set enables the early termination of iteration when using the
> foreach functions provided by gatt_db and queue.  This makes it possible to
> make some iterations more efficient.
>
> v1 -> v2:
>   * Rebase
>   * Minor formatting fixes (thanks Arman)
>
> Michael Janssen (3):
>   shared/queue: enable early terminate foreach
>   unit/test-queue: add test for early termination
>   shared/gatt-db: enable foreach early termination
>
>  android/bluetooth.c      |  4 ++-
>  android/gatt.c           | 48 +++++++++++++++++++----------
>  android/handsfree.c      |  9 ++++--
>  android/health.c         | 36 +++++++++++++---------
>  android/tester-main.c    | 32 ++++++++++++++-----
>  emulator/hciemu.c        |  3 +-
>  monitor/keys.c           | 10 +++---
>  src/shared/att.c         | 22 ++++++++-----
>  src/shared/gatt-client.c | 25 +++++++++------
>  src/shared/gatt-db.c     | 80 +++++++++++++++++++++++++-----------------------
>  src/shared/gatt-db.h     |  2 +-
>  src/shared/hci.c         |  4 ++-
>  src/shared/mgmt.c        |  8 +++--
>  src/shared/queue.c       |  3 +-
>  src/shared/queue.h       |  2 +-
>  src/shared/uhid.c        |  6 ++--
>  tools/btgatt-client.c    | 32 +++++++++++++------
>  tools/btgatt-server.c    | 24 ++++++++++-----
>  unit/test-gatt.c         | 35 ++++++++++++---------
>  unit/test-queue.c        | 44 +++++++++++++++++++++++---
>  20 files changed, 278 insertions(+), 151 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Perhaps we should introduce this as a new API, actually looking what
code it touches maybe what we really want is to introduce a manual
iteration API such as ell have l_queue_get_entries:

/**
 * l_queue_get_entries:
 * @queue: queue object
 *
 * This function gives direct, read-only access to the internal list structure
 * of the queue.  This can be used to efficiently traverse the elements.
 *
 * Returns: A pointer to the head of the queue.
 **/
LIB_EXPORT const struct l_queue_entry *l_queue_get_entries(struct
l_queue *queue)

But then we need to make queue_entry public and let the caller control
it manually, this sounds a bit more flexible and should eliminate the
use of done/fail flags.

-- 
Luiz Augusto von Dentz
