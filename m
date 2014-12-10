Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAtRonR+z_Y4om-KQeXtqKt6bTJzs7a+VDW_PBkjXXd2VA@mail.gmail.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZL=N5qKL1QUy7-P_+om-3+g+Bh9jxMg2g-FzQsK5C+-hA@mail.gmail.com>
	<CAMudyAsSvmfFePh9jYvf0Y4cQ-HJywmJ9dXoTrw=MP6y-f=PNA@mail.gmail.com>
	<CABBYNZLK9dPbLAsMM7AHmU4NxLPU2pjVWr8v+Wh_WOCAX2WZFg@mail.gmail.com>
	<CAMudyAtRonR+z_Y4om-KQeXtqKt6bTJzs7a+VDW_PBkjXXd2VA@mail.gmail.com>
Date: Wed, 10 Dec 2014 10:56:25 +0200
Message-ID: <CABBYNZ+iZ=73ML=AnLOeWBRL2yRpymE_wKM2GODV=986JU_tgA@mail.gmail.com>
Subject: Re: [PATCH 00/25] android/gatt: Fix HOG connect/disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Dec 10, 2014 at 10:53 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Luiz,
>
> On 10 December 2014 at 09:46, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Wed, Dec 10, 2014 at 10:38 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> Hi Luiz,
>>>
>>> On 10 December 2014 at 08:23, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Lukasz,
>>>>
>>>> On Tue, Dec 9, 2014 at 5:11 PM, Lukasz Rymanowski
>>>> <lukasz.rymanowski@tieto.com> wrote:
>>>>> When testing HOG against PTS we got failing testes if devices were
>>>>> not bonded before the test.
>>>>> With those patches this issue is not valid anymore.
>>>>>
>>>>> This set address couple of issues:
>>>>> * Some minor fixes found during work on those patches (first 4 patches)
>>>>>
>>>>> * Changed GATT behaviour during dedicated bonding. Now GATT will not start
>>>>> search services until bonding is done. That fixes PTS connection issue
>>>>> (patches 5-8)
>>>>>
>>>>> * Tracking of GATT operations in hog/dis/bas/scpp. After I solved PTS
>>>>> connection issue I could very easily observe many of crashes in BfA when
>>>>> disconnecting HOG during service search session. This is because HOG
>>>>> talks directly to gattrib and clear his attrib instance on HOG disconnect
>>>>> even there are ongoing GATT operations. Patches 9 - 25 solve this issue.
>>>>
>>>> I remember applying a patch from Arman that should have fixed the
>>>> problem above: shared/att: cancel_all before calling disconnect cb. In
>>>> any if that doesn't really solve the problem the client should cancel
>>>> their pending operations before releasing its reference which means no
>>>> callback should be called after that.
>>>
>>> This is problem above bt_att, but It might be worth to consider such
>>> scenario in shared/gatt.
>>> Anyway, In Android  attrib is used by HOG and also GATT with all the
>>> applications above. GATT controls registered clients so if one client
>>> unregister we should not see the problem. But if HOG and GATT  have
>>> ongoing gatt operations and in this point of time  we disconnect HOG,
>>> we should not break ongoing  gatt operations for GATT (Android apps).
>>> Note that link LE link can be still up because of some other GATT
>>> application so no disconnect_cb will be called by shared/add. Thats
>>> why attrib client should take care for its operations
>>
>> Yep, but that why I said you should probably cancel any operations,
>> which seems you did, but then why you keep checking for disconnected
>> in the callbacks? There looks like there another bug going on.
>
> Canceling operation might not succeed, in that case callback will be
> called anyway but unfortunately e.g. hog->attrib will be not valid
> anymore and that's we need that additional check.

Not succeed? bt_att_cancel should always succeed except if we cannot
find the id.
