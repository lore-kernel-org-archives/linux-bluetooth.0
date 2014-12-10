Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLK9dPbLAsMM7AHmU4NxLPU2pjVWr8v+Wh_WOCAX2WZFg@mail.gmail.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZL=N5qKL1QUy7-P_+om-3+g+Bh9jxMg2g-FzQsK5C+-hA@mail.gmail.com>
	<CAMudyAsSvmfFePh9jYvf0Y4cQ-HJywmJ9dXoTrw=MP6y-f=PNA@mail.gmail.com>
	<CABBYNZLK9dPbLAsMM7AHmU4NxLPU2pjVWr8v+Wh_WOCAX2WZFg@mail.gmail.com>
Date: Wed, 10 Dec 2014 09:53:24 +0100
Message-ID: <CAMudyAtRonR+z_Y4om-KQeXtqKt6bTJzs7a+VDW_PBkjXXd2VA@mail.gmail.com>
Subject: Re: [PATCH 00/25] android/gatt: Fix HOG connect/disconnect
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10 December 2014 at 09:46, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Dec 10, 2014 at 10:38 AM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> Hi Luiz,
>>
>> On 10 December 2014 at 08:23, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Lukasz,
>>>
>>> On Tue, Dec 9, 2014 at 5:11 PM, Lukasz Rymanowski
>>> <lukasz.rymanowski@tieto.com> wrote:
>>>> When testing HOG against PTS we got failing testes if devices were
>>>> not bonded before the test.
>>>> With those patches this issue is not valid anymore.
>>>>
>>>> This set address couple of issues:
>>>> * Some minor fixes found during work on those patches (first 4 patches)
>>>>
>>>> * Changed GATT behaviour during dedicated bonding. Now GATT will not start
>>>> search services until bonding is done. That fixes PTS connection issue
>>>> (patches 5-8)
>>>>
>>>> * Tracking of GATT operations in hog/dis/bas/scpp. After I solved PTS
>>>> connection issue I could very easily observe many of crashes in BfA when
>>>> disconnecting HOG during service search session. This is because HOG
>>>> talks directly to gattrib and clear his attrib instance on HOG disconnect
>>>> even there are ongoing GATT operations. Patches 9 - 25 solve this issue.
>>>
>>> I remember applying a patch from Arman that should have fixed the
>>> problem above: shared/att: cancel_all before calling disconnect cb. In
>>> any if that doesn't really solve the problem the client should cancel
>>> their pending operations before releasing its reference which means no
>>> callback should be called after that.
>>
>> This is problem above bt_att, but It might be worth to consider such
>> scenario in shared/gatt.
>> Anyway, In Android  attrib is used by HOG and also GATT with all the
>> applications above. GATT controls registered clients so if one client
>> unregister we should not see the problem. But if HOG and GATT  have
>> ongoing gatt operations and in this point of time  we disconnect HOG,
>> we should not break ongoing  gatt operations for GATT (Android apps).
>> Note that link LE link can be still up because of some other GATT
>> application so no disconnect_cb will be called by shared/add. Thats
>> why attrib client should take care for its operations
>
> Yep, but that why I said you should probably cancel any operations,
> which seems you did, but then why you keep checking for disconnected
> in the callbacks? There looks like there another bug going on.

Canceling operation might not succeed, in that case callback will be
called anyway but unfortunately e.g. hog->attrib will be not valid
anymore and that's we need that additional check.

>
>> \Lukasz
>>>
>>>> Lukasz Rymanowski (25):
>>>>   android/bluetooth: Minor typo fix
>>>>   android/bluetooth: Minor fix, add missing NULL assignment
>>>>   android/gatt: Fix for setting conn timeout
>>>>   android/hog: Minor coding style fixes
>>>>   android/bluetooth: Add possibility to register for bonded event
>>>>   android/gatt: Add paired cb to gatt.c
>>>>   android/bluetooth: Add API to check if device is bonding
>>>>   android/gatt: Improve LE connection after pair
>>>>   android/hog: Add support to track gatt operations
>>>>   android/hog: Cancel all GATT operations on disconnect
>>>>   android/hog: Add guards to the callbacks
>>>>   android/hog: Keep track on primary and include service search
>>>>   android/hog: Keep track on discover characteristic and descriptors
>>>>   android/hog: Keep track on read/write char and descr
>>>>   android/bas: Add queue to keep track on GATT operations
>>>>   android/bas: Keep track read/write GATT operations
>>>>   android/bas: Keep track on discover characteristic and descriptor
>>>>   android/bas: Add guard to GATT callbacks
>>>>   android/dis: Add queue to keep track on GATT operations
>>>>   android/dis: Keep track on discover and read characteristic
>>>>   android/dis: Add guard for GATT callbacks
>>>>   android/scpp: Add queue to keep GATT operations
>>>>   android/scpp: Keep track on discover characteristic and descriptor
>>>>   android/scpp: Keep track on write operation
>>>>   android/scpp: Add guard for GATT callbacks
>>>>
>>>>  android/bas.c       | 192 +++++++++++++++++++++++--
>>>>  android/bluetooth.c |  52 ++++++-
>>>>  android/bluetooth.h |   5 +
>>>>  android/dis.c       | 123 +++++++++++++++-
>>>>  android/gatt.c      |  70 ++++++++-
>>>>  android/hog.c       | 401 +++++++++++++++++++++++++++++++++++++++++++++-------
>>>>  android/scpp.c      | 171 ++++++++++++++++++++--
>>>>  7 files changed, 932 insertions(+), 82 deletions(-)
>>>>
>>>> --
>>>> 1.8.4
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
