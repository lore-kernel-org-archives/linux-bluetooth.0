Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A5A941D6-C4EB-45A1-96A5-8E9E2990EEDB@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
	<8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
	<CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
	<8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
	<CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
	<07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org>
	<CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com>
	<A5A941D6-C4EB-45A1-96A5-8E9E2990EEDB@holtmann.org>
Date: Wed, 22 Oct 2014 00:19:20 +0800
Message-ID: <CAAJw_Zvd3rq745QPRinnRivsYkYKH6QAHGSikEaFajY7go3yew@mail.gmail.com>
Subject: Re: how to set PSCAN mode in .conf?
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 21, 2014 at 7:06 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> If anyone wants to implement action 0x00 semantics on BR/EDR, then it requires using Periodic Inquiry. It is possible, but it is not a common use case these days.

Marcel,

If that's not common, perhaps not necessary.

But, I still want explore setting the "discoverable" and "connectable"
in main.conf ... will you consider a patch if I work on that? I'm
working on the raspberry Pi and every seconds count on the slow CPU
and if these config can be set without hciconfig, it'll save another
command.

Currently, I'm doing this ...
    # { sleep 3 && hciconfig hci0 piscan 2>/dev/null; } &


Thanks,
Jeff.
