Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e8ea545c-6ac1-0512-49b7-5d2cf86d6399@felipetonello.com>
References: <1485287564-16879-1-git-send-email-brian.gix@intel.com>
 <1485287564-16879-3-git-send-email-brian.gix@intel.com> <DEBB0CAA2616974FAE35E4B560B9A4372278422C@ORSMSX103.amr.corp.intel.com>
 <6feed7de-27f4-f484-e851-1e5a459e154b@felipetonello.com> <DEBB0CAA2616974FAE35E4B560B9A43722784AA9@ORSMSX103.amr.corp.intel.com>
 <e8ea545c-6ac1-0512-49b7-5d2cf86d6399@felipetonello.com>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Wed, 25 Jan 2017 19:53:20 +0200
Message-ID: <CACumGO+ga3p13ZWW3iTsEqvzA6wb_oUYn5=F9gP7in1S4e1PNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Make unit test compatible with GLIB v2.28
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 25, 2017 at 7:03 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Brian,
>
> On 25/01/17 16:43, Gix, Brian wrote:
>> Hi Felipe,
>>
>> On 25/1/17 Felipe Ferreri Tonello wrote:
>>>
>>> Hi Brian,
>>>
>>> On 24/01/17 20:10, Gix, Brian wrote:
>>>>
>>>> H Luiz, Felipe, Szymon,
>>>>
>>>>> From: Gix, Brian
>>>>>
>>>>> ---
>>>>>  unit/test-midi.c | 8 ++++++--
>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/unit/test-midi.c b/unit/test-midi.c index
>>>>> d318b07..3995c86 100644
>>>>> --- a/unit/test-midi.c
>>>>> +++ b/unit/test-midi.c
>>>>> @@ -282,8 +282,12 @@ static void compare_events(const
>>> snd_seq_event_t
>>>>> *ev1,
>>>>>                            ev2->data.control.value);
>>>>>            break;
>>>>>    case SND_SEQ_EVENT_SYSEX:
>>>>> -          g_assert_cmpmem(ev1->data.ext.ptr, ev1->data.ext.len,
>>>>> -                          ev2->data.ext.ptr, ev2->data.ext.len);
>>>>> +          g_assert_cmpint(ev1->data.ext.len,
>>>>> +                          ==,
>>>>> +                          ev2->data.ext.len);
>>>>> +          g_assert(memcmp(ev1->data.ext.ptr,
>>>>> +                          ev2->data.ext.ptr,
>>>>> +                          ev2->data.ext.len) == 0);
>>>>>            break;
>>>>>    default:
>>>>>            g_assert_not_reached();
>>>>
>>>>
>>>> Here is a straightforward rework of the g_assert_cmpmem assert.
>>>>
>>>> It was used only once, and both replacement asserts existed pre-v2.28
>>>>
>>>
>>> Fine by me, but make sure you add a relevant comment in the git message,
>>> please.
>>>
>>> Just the title is not enough. You could write something like:
>>>
>>> g_assert_cmpmem was added in version X of glib and since we don't want to
>>> bump the required version of glib for BlueZ because of a unit-test, we use
>>> g_assert_cmpint and g_assert to replace previous code.
>>
>>
>> I can put this in the comment if people like, but it is a very straightforward change.
>>
>> You don't think the existing comment makes it clear that the change is being done to avoid up-reving GLIB?
>
> IMO, no.
>
> It doesn't make clear why you decided to change the code instead of
> change the glib requirement.
>
>>
>> It is a *very* isolated change that affects only asserts, for the reason given in the headline. I think more verbiage would be excessive.
>
> Well, I have given my opinion, but this is too small for me to push it.
> It is up to Luiz to decide if he is ok with it.

The more information the better, but in this case I can added it myself.
