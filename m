Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/2] client: Fix completion for list/pair command
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com>
CC: <linux-bluetooth@vger.kernel.org>
Message-ID: <9760d084-355f-1398-d3b6-4ff1c954f6e0@jp.fujitsu.com>
Date: Wed, 20 Sep 2017 15:54:53 +0900
MIME-Version: 1.0
In-Reply-To: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 09/05/2017 01:50 PM, ERAMOTO Masaya wrote:
> The unexpected generator is used if the input string forward matches
> with the unexpected command string which a generator for completion
> is registered on. Thus,
>   - since 496b6abf743440e937222c62768e0a3b31f47f02, list command
>     generates the unneeded argument, which is device id like that
>     list-attributes command generates.
>   - since b0fe6045b7d9cfdd02a5e419fc9658a0ffa84619, pair command
>     generates the invalid argument, which is on/off like that
>     pairable command generates.
> This patch use the exact matching command.
> ---
>  client/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Could you help to have a review?

By any chance, are you working on this function? And does this patch
do conflict?


Regards,
Eramoto

