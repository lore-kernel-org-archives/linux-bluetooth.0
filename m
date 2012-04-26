Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120419021606.GC1327@pcacjr.at.laptop>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-10-git-send-email-jprvita@openbossa.org>
	<20120419021606.GC1327@pcacjr.at.laptop>
Date: Thu, 26 Apr 2012 16:42:34 -0300
Message-ID: <CAAngNMZ-ZKmw4TkubmDHX43CzfOfqUV69p5rEQznJ8wgTnLd7A@mail.gmail.com>
Subject: Re: [RFC v2 09/16] HoG: HID I/O driver
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Paulo Alcantara <pcacjr@zytor.com>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/18 Paulo Alcantara <pcacjr@zytor.com>:
> Hi Joao,
>
> On Wed, Apr 18, 2012 at 07:08:17PM -0300, João Paulo Rechi Vita wrote:
>> @@ -188,6 +211,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>               else
>>                       DBG("\t %02x %02x", value[i], value[i + 1]);
>>       }
>> +
>> +     /* create UHID device */
>> +     memset(&ev, 0, sizeof(ev));
>> +     ev.type = UHID_CREATE;
>> +     /* TODO: get info from DIS */
>> +     strcpy((char*)ev.u.create.name, "bluez-hog-device");
>
> Wouldn't the correct coding style for the cast be "char *" ?
>

Yes, fixed.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
