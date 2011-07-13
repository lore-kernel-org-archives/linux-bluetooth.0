Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKQVzUEcZnEkf3QJpsf7iJJfU+KcapywiXBh-5UvRa53Q@mail.gmail.com>
References: <1310482245-2734-1-git-send-email-luiz.dentz@gmail.com>
 <CAMOw1v6ue=3u1NfS7ZC+3g9q-XaqLi+8mm0ZW9k0rqJvfQaMLw@mail.gmail.com> <CABBYNZKQVzUEcZnEkf3QJpsf7iJJfU+KcapywiXBh-5UvRa53Q@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 13 Jul 2011 16:47:50 -0300
Message-ID: <CAMOw1v7BFNPxy0EKXeULuV70x-w47CVtEWx8BJE4J5pg=keydw@mail.gmail.com>
Subject: Re: [PATCH hcidump 2/2 v2] Add parsing for AVRCP GetCapabilities
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

On Wed, Jul 13, 2011 at 4:37 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>>> +                       printf("%s: 0x", cap2str(cap));
>>> +                       for (i = 0; i < 3; i++)
>>> +                               printf("%02x", get_u8(frm));
>>
>> Humn... I think this is not what you want. Since this information is
>> always in big endian order, you may need to convert it to host
>> architecture in order to see meaningful numbers. E.g.: if you do like
>> you're doing, when receiving a packet with COMPANY_ID == IEEE_BTSIG,
>> the information printed will be 0x581900 instead of the expected
>> 0x001958.
>
> It works just fine, we are printing byte by byte as it comes e.g. sony mw600:
>
>> AVCTP: Command : pt 0x00 transaction 5 pid 0x110e
>    AV/C: Status: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0001
>        CapabilityID: 0x02 (CompanyID)

Right... After all it comes as big endian, so you indeed shouldn't
have any issue.

Sorry, for the noise. It looks good now.



Lucas De Marchi
