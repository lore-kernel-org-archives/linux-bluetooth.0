Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140918091224.GB3505@aemeltch-MOBL1>
References: <1410958185-3878-1-git-send-email-luiz.dentz@gmail.com>
	<20140918091224.GB3505@aemeltch-MOBL1>
Date: Thu, 18 Sep 2014 13:13:12 +0300
Message-ID: <CABBYNZKNyqmXPgbK4yfGWBj17dN4mhN6vHkg4S0t_7mXeny6+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] emulator/btdev: Add iovec support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Sep 18, 2014 at 12:12 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Sep 17, 2014 at 03:49:44PM +0300, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This convert btdev_set_send_handler to take struct iovec for doing
>> scatter io.
>
> ...
>
>> --- + iov2[1].iov_base = &hdr;
>> +     iov2[1].iov_len = sizeof(hdr);
>>
>> -     if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, pkt_data, pkt_len))
>> -             send_packet(btdev, pkt_data, pkt_len);
>> +     for (i = 0; i < iovlen; i++) {
>> +             hdr.plen += iov[i].iov_len;
>> +             iov2[2 + i].iov_base = iov[i].iov_base;
>> +             iov2[2 + i].iov_len = iov[i].iov_len;
>> +     }
>>
>> -     free(pkt_data);
>> +     if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i].iov_base,
>> +
>> iov[i].iov_len))
>
> This is wrong memory access. i == iovlen here.

Yep, but it looks there is nothing using the hooks, anyway I will fix
it in a minute.


-- 
Luiz Augusto von Dentz
