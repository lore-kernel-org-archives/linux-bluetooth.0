Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5F8872D1-8947-4AA0-9F73-808D8A9D4440@holtmann.org>
References: <20171219124059.4466-1-luiz.dentz@gmail.com> <20171219124059.4466-3-luiz.dentz@gmail.com>
 <5F8872D1-8947-4AA0-9F73-808D8A9D4440@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Dec 2017 15:38:32 -0200
Message-ID: <CABBYNZ+ym8zn_DJL_-re4VqJRw3w_UtSaw2waUEjmmRdjcFAhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] lib: Introduce bt_appeartostr
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 19, 2017 at 3:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This adds bt_appeartostr which can decode the appearance code to a
>> human readable string.
>> ---
>> lib/bluetooth.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> lib/bluetooth.h |  1 +
>> 2 files changed, 88 insertions(+)
>>
>> diff --git a/lib/bluetooth.c b/lib/bluetooth.c
>> index 3276b68a5..75d94dbfa 100644
>> --- a/lib/bluetooth.c
>> +++ b/lib/bluetooth.c
>
> I really do not want to extend libbluetooth.so anymore with new functionality. If you want to do some things in src/shared/ then fine, but nothing is going to move into lib/ anymore.

Fair enough, I guess I will put these under shared/util.h then.


-- 
Luiz Augusto von Dentz
