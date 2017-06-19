Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
References: <fa395eee-ee8e-4878-7736-d2d281e06689@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Jun 2017 14:55:02 +0300
Message-ID: <CABBYNZ+iku5yyLj+k0TgA075Jg1Bw7=WMD1GgLmrUqWdvHhOuw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] client: Improve help command
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Jun 19, 2017 at 2:22 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> This adds alias-related help messages and makes more readable in whole.
>
> Changes since v1:
>  -rebase patches
>
>
> ERAMOTO Masaya (3):
>   client: Compare a input string and each command only once
>   client: Add a description to all commands
>   client: Output a long message by two lines
>
>  client/main.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
