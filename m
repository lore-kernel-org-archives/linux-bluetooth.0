Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AC7B3B6F-9FCF-472D-9844-B076B4D66C81@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
	<8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
	<CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
	<8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
	<CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
	<07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org>
	<CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com>
	<A5A941D6-C4EB-45A1-96A5-8E9E2990EEDB@holtmann.org>
	<CAAJw_Zvd3rq745QPRinnRivsYkYKH6QAHGSikEaFajY7go3yew@mail.gmail.com>
	<AC7B3B6F-9FCF-472D-9844-B076B4D66C81@holtmann.org>
Date: Wed, 22 Oct 2014 01:02:26 +0800
Message-ID: <CAAJw_ZvMTL0D57Zs+w2bq+RdRMYEqQ9g13GU-TP6g1Z_xgGGmQ@mail.gmail.com>
Subject: Re: how to set PSCAN mode in .conf?
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 22, 2014 at 12:44 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

>> Currently, I'm doing this ...
>>    # { sleep 3 && hciconfig hci0 piscan 2>/dev/null; } &
>
> I am confused why you not just use bluetoothctl (or you own tool/script) and set it. bluetoothd will enforce that setting correct for you.

Marcel,

I guess I didn't try hard enough. I just tried bluetoothctl in my
script and it's working. No "sleep" needed.

Thank again,

Jeff.
