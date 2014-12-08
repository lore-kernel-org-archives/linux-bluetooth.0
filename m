Return-Path: <cyrus@holtmann.org>
Message-ID: <54856FE3.7030808@tieto.com>
Date: Mon, 08 Dec 2014 10:31:15 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/5] android/gatt: Fix write commands being not handled
References: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>	<1418026960-21104-3-git-send-email-jakub.tyszkowski@tieto.com>	<CABBYNZKn6uTjSZzPkWkLoy5Qqwtxiyaa2L5bz67RJMCabmYYRw@mail.gmail.com> <CABBYNZKUXThYFoYqCnJUJSpsp4J-Gs0_sdvM1-vHkpOpHXnBdQ@mail.gmail.com>
In-Reply-To: <CABBYNZKUXThYFoYqCnJUJSpsp4J-Gs0_sdvM1-vHkpOpHXnBdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 12/08/2014 10:22 AM, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>
> On Mon, Dec 8, 2014 at 10:55 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Jakub,
>>
>> On Mon, Dec 8, 2014 at 10:22 AM, Jakub Tyszkowski
>> <jakub.tyszkowski@tieto.com> wrote:
>>> Registering for GATTRIB_ALL_REQS now means only requests and not commands
>>> or other type of att operations. Those needs their own handlers to be
>>> registered.
>>
>> Is this something we break while with the internal changes to use
>> bt_gatt* internally? Maybe we should have it fixed there instead since
>> it perhaps breaks the core daemon as well. Going forward this code
>> will transition to use bt_gatt* directly.
>
> Looks like this code is to blame:
>
> opcode_match:
>
> if (opcode == BT_ATT_ALL_REQUESTS &&
>     get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
> return true;
>
> Id say this turn BT_ATT_ALL_REQUESTS not that convenient for server
> since, and looking at gatt-server.c you can clearly see how many
> handlers we end up doing, perhaps we could something like this:
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index bc01827..3b52607 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -661,7 +661,7 @@ struct notify_data {
>   static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
>   {
>          if (opcode == BT_ATT_ALL_REQUESTS &&
> -                                   get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
> +                                   get_op_type(test_opcode) != ATT_OP_TYPE_RSP)
>                  return true;
>
>          return opcode == test_opcode;
>
Yeap, that's the line. I assumed that this change was intended and we 
should make the daemon compatible with this new semantic.
I've looked through the code where ALL_REQUESTS is used and I think 
there is no other place affected by this.

Regards
