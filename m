Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: how to set PSCAN mode in .conf?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAJw_Zvd3rq745QPRinnRivsYkYKH6QAHGSikEaFajY7go3yew@mail.gmail.com>
Date: Tue, 21 Oct 2014 09:44:17 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <AC7B3B6F-9FCF-472D-9844-B076B4D66C81@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com> <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org> <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com> <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org> <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com> <07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org> <CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com> <A5A941D6-C4EB-45A1-96A5-8E9E2990EEDB@holtmann.org> <CAAJw_Zvd3rq745QPRinnRivsYkYKH6QAHGSikEaFajY7go3yew@mail.gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

>> If anyone wants to implement action 0x00 semantics on BR/EDR, then it requires using Periodic Inquiry. It is possible, but it is not a common use case these days.
> 
> Marcel,
> 
> If that's not common, perhaps not necessary.
> 
> But, I still want explore setting the "discoverable" and "connectable"
> in main.conf ... will you consider a patch if I work on that? I'm
> working on the raspberry Pi and every seconds count on the slow CPU
> and if these config can be set without hciconfig, it'll save another
> command.
> 
> Currently, I'm doing this ...
>    # { sleep 3 && hciconfig hci0 piscan 2>/dev/null; } &

I am confused why you not just use bluetoothctl (or you own tool/script) and set it. bluetoothd will enforce that setting correct for you.

Regards

Marcel

