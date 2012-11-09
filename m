Return-Path: <cyrus@holtmann.org>
Message-id: <109CEFB6271D4E008DDDE261E15AC5A0@sisodomain.com>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1352372667-18288-1-git-send-email-sunil.behera@samsung.com>
 <CABBYNZ+K+R_i6ofgCP9rgsOPP2rBVk_9RKG=Q1v4BVRO_RCRCw@mail.gmail.com>
 <1F1B79404D1345F5B0892E4441A11BA5@sisodomain.com>
 <CABBYNZ+DJrDNDYYKy9tF0mud=zyVrrXB754j_VTPcHqq=aL8Aw@mail.gmail.com>
In-reply-to: <CABBYNZ+DJrDNDYYKy9tF0mud=zyVrrXB754j_VTPcHqq=aL8Aw@mail.gmail.com>
Subject: Re: [PATCH obexd v1 2/3] MAP: Add MSETime application parameter
Date: Fri, 09 Nov 2012 21:36:49 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Friday, November 09, 2012 9:10 PM
To: "Sunil Kumar Behera" <sunil.behera@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd v1 2/3] MAP: Add MSETime application parameter

> Hi Sunil,
>
> On Fri, Nov 9, 2012 at 1:29 PM, Sunil Kumar Behera
> <sunil.behera@samsung.com> wrote:
>> Hi Luiz,
>>
>> --------------------------------------------------
>> From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
>> Sent: Friday, November 09, 2012 3:33 PM
>> To: "Sunil Kumar Behera" <sunil.behera@samsung.com>
>> Cc: <linux-bluetooth@vger.kernel.org>
>> Subject: Re: [PATCH obexd v1 2/3] MAP: Add MSETime application parameter
>>
>>
>>> Hi Sunil,
>>>
>>> On Thu, Nov 8, 2012 at 1:04 PM, Sunil Kumar Behera
>>> <sunil.behera@samsung.com> wrote:
>>>>
>>>> MSETime application parameter shall be used in the response
>>>> to report the Local Time basis of the MSE.
>>>> ---
>>>>  plugins/mas.c      |    4 +++-
>>>>  plugins/messages.h |    1 +
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/plugins/mas.c b/plugins/mas.c
>>>> index 319c87f..bdf2b6b 100644
>>>> --- a/plugins/mas.c
>>>> +++ b/plugins/mas.c
>>>> @@ -284,7 +284,7 @@ static const char *yesorno(gboolean a)
>>>>  }
>>>>
>>>>  static void get_messages_listing_cb(void *session, int err, uint16_t
>>>> size,
>>>> -                                       gboolean newmsg,
>>>> +                                       gboolean newmsg, gchar 
>>>> *msetime,
>>>>                                         const struct messages_message
>>>> *entry,
>>>>                                         void *user_data)
>>>>  {
>>>> @@ -403,6 +403,8 @@ proceed:
>>>>                 mas->outparams = 
>>>> g_obex_apparam_set_uint8(mas->outparams,
>>>>                                                 MAP_AP_NEWMESSAGE,
>>>>                                                 newmsg ? 1 : 0);
>>>> +               mas->outparams =
>>>> g_obex_apparam_set_string(mas->outparams,
>>>> +                                               MAP_AP_MSETIME, 
>>>> msetime);
>>>>         }
>>>>
>>>>         if (err != -EAGAIN)
>>>> diff --git a/plugins/messages.h b/plugins/messages.h
>>>> index 00a16b1..2ab4ba1 100644
>>>> --- a/plugins/messages.h
>>>> +++ b/plugins/messages.h
>>>> @@ -226,6 +226,7 @@ int messages_get_folder_listing(void *session, 
>>>> const
>>>> char *name, uint16_t max,
>>>>   */
>>>>  typedef void (*messages_get_messages_listing_cb)(void *session, int 
>>>> err,
>>>>                                         uint16_t size, gboolean newmsg,
>>>> +                                       gchar *msetime,
>>>>                                         const struct messages_message
>>>> *message,
>>>>                                         void *user_data);
>>>
>>>
>>> Do we really need to do this in the backend? We could possible
>>> generate the timestamp on get_messages_listing_cb and which should
>>> avoid having duplicate code doing the same for each backend.
>>>
>>
>> The data for application parameter MSETime is string with current time 
>> basis
>> and UTC-offset of the MSE. Since the UTC value depends on the location of
>> the device
>> so I think it is better left to backend on deciding the UTC value.
>
> We should be able to retrieve this information with tzname or timezone
> defined on time.h, so with that and gettimeofday of clock_gettime
> should be enough to generate the MSETime without having to depend on
> the backend which potentially will do the same thing, besides the
> backend could still fail to format the string properly so at least it
> should have been an integer but I still prefer to do everything in the
> plugin side.
>

ok I shall consider your suggestion and update the patch set accordingly.

I think the below mentioned patch is independent of other changes
so it can be applied
[PATCH obexd 1/3] Add get next header function in message listing.

Thanks for your suggestion.

Best Regards,
Sunil
 

