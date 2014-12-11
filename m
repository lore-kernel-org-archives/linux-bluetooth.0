Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAtSEooUF=GVL6NYchkaumKcV8oQw59DYRuGqc-=6n5+6g@mail.gmail.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZL=N5qKL1QUy7-P_+om-3+g+Bh9jxMg2g-FzQsK5C+-hA@mail.gmail.com>
	<CAMudyAsSvmfFePh9jYvf0Y4cQ-HJywmJ9dXoTrw=MP6y-f=PNA@mail.gmail.com>
	<CABBYNZLK9dPbLAsMM7AHmU4NxLPU2pjVWr8v+Wh_WOCAX2WZFg@mail.gmail.com>
	<CAMudyAtRonR+z_Y4om-KQeXtqKt6bTJzs7a+VDW_PBkjXXd2VA@mail.gmail.com>
	<CABBYNZ+iZ=73ML=AnLOeWBRL2yRpymE_wKM2GODV=986JU_tgA@mail.gmail.com>
	<CAMudyAtbm+r2n3CktFwkfh=W5_SQoSNEVKR8CKVP61GnBHQBHA@mail.gmail.com>
	<CABBYNZKP9eF4WwDGjthjZFK4G-GzTK1AsK_zG9DbiEOBtBjONw@mail.gmail.com>
	<CAMudyAtSEooUF=GVL6NYchkaumKcV8oQw59DYRuGqc-=6n5+6g@mail.gmail.com>
Date: Thu, 11 Dec 2014 16:19:00 +0100
Message-ID: <CAMudyAtXVucg1eGVU2Kr9QYvp7NBNzM-jFg6g2ggKQPbArb-Sw@mail.gmail.com>
Subject: Re: [PATCH 00/25] android/gatt: Fix HOG connect/disconnect
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10 December 2014 at 10:27, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Luiz,
>
> On 10 December 2014 at 10:25, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Wed, Dec 10, 2014 at 11:20 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> Hi Luiz,
>>>
>>> On 10 December 2014 at 09:56, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Lukasz,
>>>>
>>>> On Wed, Dec 10, 2014 at 10:53 AM, Lukasz Rymanowski
>>>> <lukasz.rymanowski@tieto.com> wrote:
>>>>> Hi Luiz,
>>>>>
>>>>> On 10 December 2014 at 09:46, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> Hi Lukasz,
>>>>>>
>>>>>> On Wed, Dec 10, 2014 at 10:38 AM, Lukasz Rymanowski
>>>>>> <lukasz.rymanowski@tieto.com> wrote:
>>>>>>> Hi Luiz,
>>>>>>>
>>>>>>> On 10 December 2014 at 08:23, Luiz Augusto von Dentz
>>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>>> Hi Lukasz,
>>>>>>>>
>>>>>>>> On Tue, Dec 9, 2014 at 5:11 PM, Lukasz Rymanowski
>>>>>>>> <lukasz.rymanowski@tieto.com> wrote:
>>>>>>>>> When testing HOG against PTS we got failing testes if devices were
>>>>>>>>> not bonded before the test.
>>>>>>>>> With those patches this issue is not valid anymore.
>>>>>>>>>
>>>>>>>>> This set address couple of issues:
>>>>>>>>> * Some minor fixes found during work on those patches (first 4 patches)
>>>>>>>>>
>>>>>>>>> * Changed GATT behaviour during dedicated bonding. Now GATT will not start
>>>>>>>>> search services until bonding is done. That fixes PTS connection issue
>>>>>>>>> (patches 5-8)
>>>>>>>>>
>>>>>>>>> * Tracking of GATT operations in hog/dis/bas/scpp. After I solved PTS
>>>>>>>>> connection issue I could very easily observe many of crashes in BfA when
>>>>>>>>> disconnecting HOG during service search session. This is because HOG
>>>>>>>>> talks directly to gattrib and clear his attrib instance on HOG disconnect
>>>>>>>>> even there are ongoing GATT operations. Patches 9 - 25 solve this issue.
>>>>>>>>
>>>>>>>> I remember applying a patch from Arman that should have fixed the
>>>>>>>> problem above: shared/att: cancel_all before calling disconnect cb. In
>>>>>>>> any if that doesn't really solve the problem the client should cancel
>>>>>>>> their pending operations before releasing its reference which means no
>>>>>>>> callback should be called after that.
>>>>>>>
>>>>>>> This is problem above bt_att, but It might be worth to consider such
>>>>>>> scenario in shared/gatt.
>>>>>>> Anyway, In Android  attrib is used by HOG and also GATT with all the
>>>>>>> applications above. GATT controls registered clients so if one client
>>>>>>> unregister we should not see the problem. But if HOG and GATT  have
>>>>>>> ongoing gatt operations and in this point of time  we disconnect HOG,
>>>>>>> we should not break ongoing  gatt operations for GATT (Android apps).
>>>>>>> Note that link LE link can be still up because of some other GATT
>>>>>>> application so no disconnect_cb will be called by shared/add. Thats
>>>>>>> why attrib client should take care for its operations
>>>>>>
>>>>>> Yep, but that why I said you should probably cancel any operations,
>>>>>> which seems you did, but then why you keep checking for disconnected
>>>>>> in the callbacks? There looks like there another bug going on.
>>>>>
>>>>> Canceling operation might not succeed, in that case callback will be
>>>>> called anyway but unfortunately e.g. hog->attrib will be not valid
>>>>> anymore and that's we need that additional check.
>>>>
>>>> Not succeed? bt_att_cancel should always succeed except if we cannot
>>>> find the id.
>>>
>>> Just checked bt_att code and indeed, after calling cancel we should be
>>> sure that callback will not be called.
>>> However, I've seen something else during testing. That might be other
>>> bug then. Will look into it probably tomorrow.
>>
>> Yep, it might be another bug or perhaps one operation that was not
>> canceled for some reason.
>
> Agree
>

In the end it seems to be bug.
I had time to look closer into it and  the problem is in attrib/gatt.c
Scenario:
When gattrib user (like HOG) calls gatt_discover_char or
gatt_discover_desc it will get valid request_id of sent or queued
request.
If remote response with not contain full range from the request then
attib/gatt.c will send following requests to remote, under the hood.
In this point of time request_id which e.g. HOG has is not valid
anymore, there is new one which is actually ignored by attrib/gatt.
This is why when later HOG is doing cancel, it gets false and in the
end callback is called with a response anyway.

To solve it, HOG needs to have latest req_id so it can cancel the
correct one (solution 1), or attrib/gatt.c has some kind of mapping on
original req_id and ongoing one (solution 2). Any other solutions are
welcome:)
Solution 1)  Some callback to gattrib user (like  HOG) with user data
and new request id so it can be updated by the user (?)
Solution 2) Here it will be tricky as  attrib/gatt.c is only wrraper
so there is no place to keep such map. We could have some table but
since req_id is unsigned int it would be huge. Of course API to cancel
request would have to wrapped in attrib/gatt.c. Maybe we could add
some init to attrib/gatt.c which would init some special queue which
would track original req_id and ongoing req_id (?)

I'm not fan of any of this solutions especially that attrib/* is going
to be removed. I would go with those patches I made and when we start
use shared/gatt, then we can remove not needed code from HOG/DIS etc

What do you think?

\Łukasz

> \Lukasz
>>
>> --
>> Luiz Augusto von Dentz
