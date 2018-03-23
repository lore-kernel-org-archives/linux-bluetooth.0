Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
References: <20180322152101.9871-1-andrzej.kaczmarek@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 Mar 2018 13:33:47 +0200
Message-ID: <CABBYNZL5YLYxd=iU--jW=CV6y7G6wSTU5FiiXVy-NJiVnfWNQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/3] Fixes for GATT discovery
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Mar 22, 2018 at 5:20 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@codecoup.pl> wrote:
> Changes from v1:
> - added extra fix for handling 'current service' in op
> - smarter calculation of discovery ranges
>
> Proper handling of inserting existing characteristic seems to be at
> least non-trivial so I did not attempt to fix it here.
>
>
> Andrzej Kaczmarek (3):
>   shared/gatt-client: Fix removing services from pending list
>   shared/gatt-client: Fix discovery of discontinuous database
>   shared/gatt-client: Fix tracking current service during discovery
>
>  src/shared/gatt-client.c | 139 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 119 insertions(+), 20 deletions(-)
>
> --
> 2.16.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
