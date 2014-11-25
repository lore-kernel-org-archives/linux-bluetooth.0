Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416870232-16692-1-git-send-email-armansito@chromium.org>
References: <1416870232-16692-1-git-send-email-armansito@chromium.org>
Date: Tue, 25 Nov 2014 23:51:05 +0200
Message-ID: <CABBYNZJXY5pzQDJhgr3CwvvzO=OjUPi=BqvrftAh4Aereof_LQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/2] shared/gatt: Bug fixes.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Nov 25, 2014 at 1:03 AM, Arman Uguray <armansito@chromium.org> wrote:
> *v1: Call io_shutdown instead of close(att->fd).
>
> Arman Uguray (2):
>   shared/att: Call io_shutdown on ATT violations.
>   shared/gatt-client: Call ready_handler only in init.
>
>  src/shared/att.c         | 21 +++++++++++++--------
>  src/shared/gatt-client.c |  3 ++-
>  2 files changed, 15 insertions(+), 9 deletions(-)
>
> --
> 2.1.0.rc2.206.gedb03e5

Applied, thanks.


-- 
Luiz Augusto von Dentz
