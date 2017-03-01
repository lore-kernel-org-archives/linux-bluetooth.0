Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+L1ozuxvxdg_6ytoHjgckGn1t=gw6VHs=NY7zZT-gJEg@mail.gmail.com>
References: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
 <1488330416-10463-3-git-send-email-juha.kuikka@synapse.com> <CABBYNZ+L1ozuxvxdg_6ytoHjgckGn1t=gw6VHs=NY7zZT-gJEg@mail.gmail.com>
From: Juha Kuikka <juha.kuikka@synapse.com>
Date: Wed, 1 Mar 2017 11:13:42 -0800
Message-ID: <CAKHsmFoWqfWkG-xnXTGrONNHnhQavFFhH=KkOj+m6=TAy0wZeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] input: Add UHIDDestroy option into input.conf
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Juha Kuikka <juha.kuikka@gmail.com>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Wed, Mar 1, 2017 at 2:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Juha,
>
> On Wed, Mar 1, 2017 at 3:06 AM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
>> UHIDDestroy controls whether uHID device is destroyed on HID/HoG disconnect.
>> Defaults to false.
>> ---
>>  profiles/input/input.conf | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/profiles/input/input.conf b/profiles/input/input.conf
>> index 3e1d65a..4a93e42 100644
>> --- a/profiles/input/input.conf
>> +++ b/profiles/input/input.conf
>> @@ -11,3 +11,7 @@
>>  # Enable HID protocol handling in userspace input profile
>>  # Defaults to false (HIDP handled in HIDP kernel module)
>>  #UserspaceHID=true
>> +
>> +# Destroy uHID device on HID/HoG disconnect
>> +# Defaults to false (uHID device is persistent across reconnects)
>> +#UHIDDestroy=true
>> --
>> 2.7.4
>
> Id follow the prefix of UserspaceHID here since it should apply to any
> uHID instance including classic and please merge this into the first
> patch.

Thanks, will do!

 - Juha
