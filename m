Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLZtEBXkEBVvrU9GUPQTOeiL979vCs6Cewh7SThAsLS-A@mail.gmail.com>
References: <CAKafyqpqOgSueeyqDWPWeyaF11+WxbU28vAHdOp+yfE=Zz3gwg@mail.gmail.com>
	<CABBYNZLZtEBXkEBVvrU9GUPQTOeiL979vCs6Cewh7SThAsLS-A@mail.gmail.com>
Date: Mon, 16 Nov 2015 18:06:41 +0530
Message-ID: <CAKafyqoe3_a2W7R+31zde-sdfitR23BkMJVHz4kdQ5cscfPO6Q@mail.gmail.com>
Subject: Re: HoG Disconnection=> Reason: Connection Time out
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Mon, Nov 16, 2015 at 2:24 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Prabhu,
>
> On Mon, Nov 16, 2015 at 7:27 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
>> Hi All,
>>
>>     When connecting a bonded HoG device, I am seeing the connection
>> unsuccessful.
>>
>> When I saw hcidump, pasted comlete hcidump below. Please let me know
>> what is the reason.
>>
>>> HCI Event: Disconn Complete (0x05) plen 4
>>     status 0x00 handle 75 reason 0x08
>>     Reason: Connection Timeout
>
> Looks like everything is fine until the timeout, does this manifest
> every time? What controller do you have, perhaps you can try with
> different controller to see if that helps, if it doesn't then you will
> probably need a sniffer to find out why it is disconnecting.
>
> Btw, can you share what device is it?
>
>
> --
> Luiz Augusto von Dentz

I am using CSR 4.0 USB BT dongle (dual mode), yes every time I see it.
Sometimes with different handle (73 and different attribute0x4b)

I am using trying with BT LE (smart)   HoG device which has touch pad, keypad.

I was digging more into it I got an error in the hcidump before the
above dump . which is pasted  below

< ACL data: handle 75 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0057, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 75 packets 1
> ACL data: handle 75 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0057

is it missing any important attribute ? 'Read By Type req' waits for
time out and drops connection. I tried enabling, when attributes are
read, in the middle connection is dropped.
How bluex comes to know about it ? is it discovered or is is mandatory
as part of Spect HoG ?

Please share your input.

Many Thanks,
Prabhu Chawandi
