Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
Date: Fri, 28 Feb 2014 12:14:01 -0400
Message-ID: <CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Fri, Feb 28, 2014 at 8:41 AM, Adam Warski <adam@warski.org> wrote:
> But then I get:
>
>> HCI Event: LE Meta Event (0x3e) plen 42
>     LE Advertising Report
>       ADV_IND - Connectable undirected advertising (0)
>       bdaddr FC:94:A8:6F:A8:10 (Random)
>       Flags: 0x06
>       Unknown type 0xff with 25 bytes data
>       RSSI: -4
>> HCI Event: QoS Violation (0x1e) plen 2
>     handle 1537
>> HCI Event: Data Buffer Overflow (0x1a) plen 255
>     type Unknown
>> HCI Event: code 0xa8 plen 148
>> HCI Event: code 0xf8 plen 70
>> HCI Event: Physical Link Complete (0x40) plen 127
>     status 0x30 phy handle 0xf5
>     Error: Parameter out of Mandatory Range

For me looks like something got confused on the HCI packet parsing:
either the kernel, hcidump, or something else. The HCI events after
the LE meta event make no sense (they seem garbage). Did you try with
btmon instead of hcidump ?

Can you save the raw dump using "hcidump -w output.dump"  (or using
btmon -w) and send to the list? It is easier to analyze, as the parser
may be bogus.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
