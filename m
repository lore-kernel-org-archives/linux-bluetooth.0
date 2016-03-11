Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLFXe9a+apB_VeDLWLHpgrHCNrWswdUDU3MjWG+q5UnRA@mail.gmail.com>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1448622711-17562-2-git-send-email-lukasz.rymanowski@codecoup.pl>
	<CABBYNZKk=RZERiZfD02mtW7sZg2G+R1cOHBfT9BU8CETHJcPyw@mail.gmail.com>
	<CAExxLLDo44eLdFnM_mmbdiWoPK-Y16K48W=79gSCLT0K5p2i6w@mail.gmail.com>
	<CAExxLLATiPgHr_nFvF5vpZei84pCKihYmB+Q5oaX6A4p+2Fe_g@mail.gmail.com>
	<CABBYNZLFXe9a+apB_VeDLWLHpgrHCNrWswdUDU3MjWG+q5UnRA@mail.gmail.com>
Date: Fri, 11 Mar 2016 16:05:11 +0100
Message-ID: <CAExxLLA6ws88fKkagyThC2U+QF24N9hbVwrqkjUOCP4MBjKQYg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] unit/test-gatt: Fix long write testcases
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 March 2016 at 15:30, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Mar 11, 2016 at 3:27 PM, Łukasz Rymanowski
> <lukasz.rymanowski@codecoup.pl> wrote:
>> Hi Luiz,
>>
>> On 3 December 2015 at 22:08, Łukasz Rymanowski
>> <lukasz.rymanowski@codecoup.pl> wrote:
>>> Hi Luiz,
>>>
>>> On Thu, Dec 3, 2015 at 10:27 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>>
>>>> Hi Łukasz,
>>>>
>>>> On Fri, Nov 27, 2015 at 1:11 PM, Łukasz Rymanowski
>>>> <lukasz.rymanowski@codecoup.pl> wrote:
>>>> > Idea of long write is that each part of data is continuation
>>>> > of previous one. There shall be not gaps in the offsets between.
>>>> >
>>>> > If there are gaps in offset then we have reliable write rather than
>>>> > long write
>>>>
>>>> The patch looks fine what I did not understand is what different it
>>>> makes if it is a reliable write or a long write, to me all long writes
>>>> are in fact reliable write since it does use prepare + execute, the
>>>> fact that only one handle is written doesn't change anything.
>>>>
>>>
>>> These testes are for Long write and there is a difference between Long Write and
>>> Reliable Write even those two use prepare/execute writes. This can be
>>> found in the
>>> BT Spec Chapter 3 Part G, 4.9.4  and 4.9.5
>>>
>>> Basically those procedure belongs to GATT and our gatt server should
>>> understand that.
>>>
>>> If we are going to not expose prepare/execute wirtes to application,
>>> then this is GATT server which should
>>> recognize procedure and prepare data to be written to application.
>>> i.e. for long write do aggregation of all
>>> prepare writes, we can not just write part of data as this would cause
>>> some unexpected behavior.
>>>
>>> We also need this change, because following patches will start to test
>>> for characteristic extended properties
>>> descriptor and do not allow reliable write on characteristics which
>>> does not have property for this.
>>> Note that for Long Write we don't need this descriptor property, so
>>> these test cases would fail then.
>>>
>>> Also, note that there is Long Write procedure for descriptors but
>>> there is no Reliable Write procedure for
>>> descriptors, so we definitely cannot treat long and prepare as the same one.
>>>
>>>
>> Was my explanation clear enough?
>>
>> Just getting back to this work and we have some outstanding patches in
>> this patchset
>> which should be OK to apply.
>
> I guess my point was not really against this patch but more on the
> detection of reliable write vs long write.

Yes I recall that,  that is why I'm asking if my explanation is OK.
Note that detection of long/prepare is done in next patch:
[PATCH v2 08/11] shared/gatt-server: Add support for long write


-- 
BR / Pozdrawiam
Łukasz
