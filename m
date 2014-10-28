Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414420542-15336-1-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Date: Tue, 28 Oct 2014 14:29:00 +0200
Message-ID: <CABBYNZLDvkaVMfgo_UCWbV2=OOgrykj4pGhYbiPsiPKqWZLNRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/7] shared/gatt: Various bug fixes.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Oct 27, 2014 at 4:35 PM, Arman Uguray <armansito@chromium.org> wrote:
> *v1:
>   - Fixed potential invalid access while obtaining end group handle.
>   - Fixed some compile warnings.
>
> Arman Uguray (7):
>   shared/gatt-client: Fix bug in service changed queue.
>   shared/gatt-client: Fix bug in service changed handling.
>   tools/btgatt-client: Fix read-long-value offset parsing.
>   tools/btgatt-client: Fix off-by-one error.
>   tools/btgatt-client: Print prompt on service changed.
>   shared/gatt-db: Fix range handling in read by grp type.
>   TODO: Add new shared/gatt TODO items.
>
>  TODO                     | 15 +++++++++++++++
>  src/shared/gatt-client.c | 14 +++++++++-----
>  src/shared/gatt-db.c     | 11 ++++++++++-
>  tools/btgatt-client.c    | 11 +++++++----
>  4 files changed, 41 insertions(+), 10 deletions(-)
>
> --
> 2.1.0.rc2.206.gedb03e5

I went ahead and applied these set and on top of it I made the
conversion to use pass 0 as base to strtol so it can auto detect the
base since this is convenient in a command line tool.


-- 
Luiz Augusto von Dentz
