Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
References: <1418691816-40271-1-git-send-email-jamuraa@chromium.org>
Date: Tue, 16 Dec 2014 16:02:34 +0200
Message-ID: <CABBYNZKoP__zfJTQMb_326+12Eb-ENJ_GsuL0p57Cz9GLFsu2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/5] Add const access to linked list for efficiency
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Tue, Dec 16, 2014 at 3:03 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> In many cases, queue_foreach is being used to find a specific item not easily
> locatable using queue_find or can be finished early.  This set adds
> queue_get_entries which gives a method for manual iteration of the queue.
>
> The other patches use this feature to improve efficiency of some iterations.
>
> Michael Janssen (5):
>   shared/queue: Add queue_get_entries
>   shared/queue: clarify queue_match_func_t arguments
>   android/health: improve search efficiency
>   monitor/keys: use queue_find over queue_foreach
>   shared/gatt-db: manual iteration when appopriate
>
>  android/health.c     | 153 +++++++++++++++++++++------------------------------
>  monitor/keys.c       |  37 ++++---------
>  src/shared/gatt-db.c | 150 ++++++++++++++++++++------------------------------
>  src/shared/queue.c   |  14 +++--
>  src/shared/queue.h   |  10 +++-
>  5 files changed, 151 insertions(+), 213 deletions(-)
>
> --
> 2.2.0.rc0.207.ga3a616c

Applied, thanks.


-- 
Luiz Augusto von Dentz
