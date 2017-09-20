Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9760d084-355f-1398-d3b6-4ff1c954f6e0@jp.fujitsu.com>
References: <611fb226-d99a-166d-a211-521872866d5d@jp.fujitsu.com> <9760d084-355f-1398-d3b6-4ff1c954f6e0@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Sep 2017 14:55:24 +0300
Message-ID: <CABBYNZ+apK_3yxOxihxb0y7YK-22fX-OsNG+DoU2aphGV_so+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client: Fix completion for list/pair command
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Wed, Sep 20, 2017 at 9:54 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> On 09/05/2017 01:50 PM, ERAMOTO Masaya wrote:
>> The unexpected generator is used if the input string forward matches
>> with the unexpected command string which a generator for completion
>> is registered on. Thus,
>>   - since 496b6abf743440e937222c62768e0a3b31f47f02, list command
>>     generates the unneeded argument, which is device id like that
>>     list-attributes command generates.
>>   - since b0fe6045b7d9cfdd02a5e419fc9658a0ffa84619, pair command
>>     generates the invalid argument, which is on/off like that
>>     pairable command generates.
>> This patch use the exact matching command.
>> ---
>>  client/main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> Could you help to have a review?
>
> By any chance, are you working on this function? And does this patch
> do conflict?
>
>
> Regards,
> Eramoto

Applied, thanks.



-- 
Luiz Augusto von Dentz
