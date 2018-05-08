Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
 <CABBYNZLSror-VgNZkL8MM_Vb+FKWrWqQ4OqgEWQcCO_+LE_Fbg@mail.gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: David Llewellyn-Jones <david@flypig.co.uk>
Message-ID: <62d18dbe-39b8-f238-3816-63030a6085ac@flypig.co.uk>
Date: Tue, 8 May 2018 09:49:09 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZLSror-VgNZkL8MM_Vb+FKWrWqQ4OqgEWQcCO_+LE_Fbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 08/05/18 08:40, Luiz Augusto von Dentz wrote:
> Hi David,
> On Mon, May 7, 2018 at 7:14 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> wrote:
> 
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
>> This adds Flags which the application can use in case it want to set
>> it own flags.
> 
>> Note: This would allow for example an application to advertise as
>> discoverable even if the adapter is not discoverable which may be
>> required by dual-mode as it may not require BR/EDR to be discoverable.
>> ---
>>   doc/advertising-api.txt | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
> 
>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>> index eef98ad91..4e015f282 100644
>> --- a/doc/advertising-api.txt
>> +++ b/doc/advertising-api.txt
>> @@ -78,6 +78,21 @@ Properties   string Type
>>                                  <Transport Discovery> <Organization
> Flags...>
>>                                  0x26                   0x01
> 0x01...
> 
>> +               array{byte} Flags [Experimental]
>> +
>> +                       Advertising Flags to include. When present this
> will
>> +                       override existing flags such as Discoverable.
>> +
>> +                       Note: This property shall not be set when Type is
> set
>> +                       to broadcast.
>> +
>> +                       Possible value:
>> +                               bit 0 - LE Limited Discoverable Mode
>> +                               bit 1 - LE General Discoverable Mode
>> +                               bit 2 - BR/EDR Not Supported
>> +                               bit 3 - Simultaneous LE and BR/EDR
> (Controller)
>> +                               bit 4 - Simultaneous LE and BR/EDR (Host)
>> +
>>                  array{string} Includes
> 
>>                          List of features to be included in the advertising
>> --
>> 2.14.3
> 
> Any feedback this set?

Thanks for making the patches. This certainly looks like it would
achieve what I need. My use of it would be to read the flags, OR bit 1
(general discovery) and write them back again, so as not to affect the
other flags.

I plan to test it by applying your patches to my local version, but I've
not yet had the chance. I'll comment back as soon as I have.

David
-- 
Website: http://www.flypig.co.uk
