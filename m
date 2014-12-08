Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Rj1vLbgCek0BaYxD+-cb4HDyB7XL3qP=ujGkuYRJSAYg@mail.gmail.com>
References: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1418026960-21104-3-git-send-email-jakub.tyszkowski@tieto.com>
	<CABBYNZKn6uTjSZzPkWkLoy5Qqwtxiyaa2L5bz67RJMCabmYYRw@mail.gmail.com>
	<CABBYNZKUXThYFoYqCnJUJSpsp4J-Gs0_sdvM1-vHkpOpHXnBdQ@mail.gmail.com>
	<54856FE3.7030808@tieto.com>
	<54857AB3.4090309@tieto.com>
	<CABBYNZKTkkN=EsfY3YYM7bGppXp10uYmURT62x-qQtBnYcDHXQ@mail.gmail.com>
	<CAHrH25Rj1vLbgCek0BaYxD+-cb4HDyB7XL3qP=ujGkuYRJSAYg@mail.gmail.com>
Date: Tue, 9 Dec 2014 00:08:30 +0200
Message-ID: <CABBYNZJ7c3dxwFH3qY3CfDqS=oQXL4Wmh1fvNpn2oU5X_C0y8w@mail.gmail.com>
Subject: Re: [PATCH 3/5] android/gatt: Fix write commands being not handled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Dec 8, 2014 at 9:50 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz & Jakub,
>
>> On Mon, Dec 8, 2014 at 3:02 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Jakub,
>>
>> On Mon, Dec 8, 2014 at 12:17 PM, Tyszkowski Jakub
>> <jakub.tyszkowski@tieto.com> wrote:
>>> Hi,
>>>
>>>
>>> On 12/08/2014 10:31 AM, Tyszkowski Jakub wrote:
>>>>
>>>> Hi Luiz,
>>>>
>>>> On 12/08/2014 10:22 AM, Luiz Augusto von Dentz wrote:
>>>>>
>>>>> Hi Jakub,
>>>>>
>>>>> On Mon, Dec 8, 2014 at 10:55 AM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>
>>>>>> Hi Jakub,
>>>>>>
>>>>>> On Mon, Dec 8, 2014 at 10:22 AM, Jakub Tyszkowski
>>>>>> <jakub.tyszkowski@tieto.com> wrote:
>>>>>>>
>>>>>>> Registering for GATTRIB_ALL_REQS now means only requests and not
>>>>>>> commands
>>>>>>> or other type of att operations. Those needs their own handlers to be
>>>>>>> registered.
>>>>>>
>>>>>>
>>>>>> Is this something we break while with the internal changes to use
>>>>>> bt_gatt* internally? Maybe we should have it fixed there instead since
>>>>>> it perhaps breaks the core daemon as well. Going forward this code
>>>>>> will transition to use bt_gatt* directly.
>>>>>
>>>>>
>>>>> Looks like this code is to blame:
>>>>>
>>>>> opcode_match:
>>>>>
>>>>> if (opcode == BT_ATT_ALL_REQUESTS &&
>>>>>     get_op_type(test_opcode) == ATT_OP_TYPE_REQ)
>>>>> return true;
>>>>>
>>>>> Id say this turn BT_ATT_ALL_REQUESTS not that convenient for server
>>>>> since, and looking at gatt-server.c you can clearly see how many
>>>>> handlers we end up doing, perhaps we could something like this:
>>>>>
>>>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>>>> index bc01827..3b52607 100644
>>>>> --- a/src/shared/att.c
>>>>> +++ b/src/shared/att.c
>>>>> @@ -661,7 +661,7 @@ struct notify_data {
>>>>>   static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
>>>>>   {
>>>>>          if (opcode == BT_ATT_ALL_REQUESTS &&
>>>>> -                                   get_op_type(test_opcode) ==
>>>>> ATT_OP_TYPE_REQ)
>>>>> +                                   get_op_type(test_opcode) !=
>>>>> ATT_OP_TYPE_RSP)
>>>>>                  return true;
>>>
>>>
>>> If we do that, we are still left with other stuff like indications or even
>>> confirmations which would still be quite quirky for using *ALL_REQESTS in
>>> name.
>>
>> Perhaps we check ATT_OP_TYPE_CMD in addition to ATT_OP_TYPE_REQ.
>>
>>>>>
>>>>>          return opcode == test_opcode;
>>>>>
>>>> Yeap, that's the line. I assumed that this change was intended and we
>>>> should make the daemon compatible with this new semantic.
>>>> I've looked through the code where ALL_REQUESTS is used and I think
>>>> there is no other place affected by this.
>>>>
>
> The change in bt_att was really done to make GAttrib's ALL_REQUESTS
> behavior work, otherwise we wouldn't have added it. In general, new
> code should just register individual handler functions for the
> specific opcodes it wants to handle. This leads to cleaner code, and
> avoids the kind of huge switch/if statements you end up needing with
> an ALL_* handler.

I would classify a command as a request as well which apparently is
not the case anymore, anyway the problem is that ALL_REQUESTS was
create to map to GAttrib but we end up with something different thus
breaking Android code. For new code you actually should not register
handler yourself, except as a client for notifications and
indications, since bt_gatt_server should take care of those but I
agree that is probably cleaner to have each handler registered
separately.

> So for notifications/indications, you should really just register a
> handler with the associated opcodes.

Yep, that should really be the only handlers outside bt_gatt_server scope.

> As a note: bt_att doesn't allow registering handlers for incoming
> response PDUs. Instead, those are propagated to the upper layer via
> the callback passed to bt_att_send when the request was originally
> sent out. Basically, you don't get to know about a response unless you
> sent out the request in the first place (and AFAIK this is the case
> with GAttrib as well).

I guess we were discussing how to get the same behavior as in GAttrib
ALL_REQUESTS, this would probably be removed once we transition to
bt_gatt_server.


-- 
Luiz Augusto von Dentz
