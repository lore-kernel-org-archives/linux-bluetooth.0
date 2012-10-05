Return-Path: <cyrus@holtmann.org>
Message-id: <506EA0F0.4070501@samsung.com>
Date: Fri, 05 Oct 2012 17:57:20 +0900
From: Chan-yeol Park <chanyeol.park@samsung.com>
MIME-version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	chanyeol.park@samsung.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] audio: Add check for non-a2dp codec
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
 <CABBYNZKHzKv+GQhynnGN04O17kwjDobwL-+CeVB9hJqrVEF05A@mail.gmail.com>
 <506E8AA5.7090709@gmail.com> <1349426477.27233.44.camel@aeonflux>
In-reply-to: <1349426477.27233.44.camel@aeonflux>
Content-type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
On 10/05/2012 05:41 PM, Marcel Holtmann wrote:
> Hi Chan-yeol,
>
>>>    #define SBC_SAMPLING_FREQ_16000                (1 << 3)
>>>    #define SBC_SAMPLING_FREQ_32000                (1 << 2)
>>> @@ -114,3 +115,8 @@ typedef struct {
>>>    #else
>>>    #error "Unknown byte order"
>>>    #endif
>>> +
>>> +typedef struct {
>>> +       uint8_t vendor_id[4];
>>> +       uint8_t codec_id[2];
>>> +} __attribute__ ((packed)) non_a2dp_vendor_codec_t;
>>> We normally don't typedef this type of structs, besides
>>> a2dp_vendor_codec should be enough so this should be named struct
>>> a2dp_vendor_codec.
>> You're right. originally I didn't use typedef.
>> but in order to achieve harmony in a2dp-codecs.h like sbc,mpeg, I've
>> changed it.
>>
>> If you make decision about this, I will raise a second patch.
> hold on for a second, is this the file that is shared with PulseAudio?
Yes right. PulseAudio copy it as far as I know.

Regards
