Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OFG4JSxrHzLY9X7uG34U-N8bD7=Rb=ZXq-t779mCc-Mw@mail.gmail.com>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-9-git-send-email-jprvita@openbossa.org>
	<CAJdJm_OFG4JSxrHzLY9X7uG34U-N8bD7=Rb=ZXq-t779mCc-Mw@mail.gmail.com>
Date: Thu, 26 Apr 2012 16:43:12 -0300
Message-ID: <CAAngNMbcQLRLeiQox7MM8MOti-uCGgJETGGUT6VSnC8df=1=JQ@mail.gmail.com>
Subject: Re: [RFC v2 08/16] HoG: add report notification handler
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/20 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi João,
>
> 2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
>> ---
>>  input/hog_device.c |   21 +++++++++++++++++++++
>>  1 files changed, 21 insertions(+), 0 deletions(-)
>>
>> diff --git a/input/hog_device.c b/input/hog_device.c
>> index ac6d4c9..5df6879 100644
>> --- a/input/hog_device.c
>> +++ b/input/hog_device.c
>> @@ -71,9 +71,27 @@ static void report_free(struct report *report)
>>        g_free(report);
>>  }
>>
>> +static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
>> +{
>> +       uint16_t handle;
>> +
>> +       if (len < 3) {
>
> I suppose the check should be (len < 10) here ? Otherwise the DBG()
> call will read invalid data.
>
>> +               error("Malformed ATT notification");
>> +               return;
>> +       }
>> +
>> +       handle = att_get_u16(&pdu[1]);
>> +
>> +       DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
>> +                               "0x%02x", handle, pdu[2], pdu[3], pdu[4],
>> +                               pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);
>
> This DBG() seems strange. If handle starts at (pdu + 1) and has two
> octets, the remaining bytes should start at (pdu + 3).
>

The right thing to do here is to keep the initial check for len < 3
(1-byte opcode + 2-byte handle) and remove this debug entirely. It was
helpful during development, but normally we won't want one debug
message for every input event, even in debug mode.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
