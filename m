Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: how to set PSCAN mode in .conf?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com>
Date: Tue, 21 Oct 2014 04:06:40 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <A5A941D6-C4EB-45A1-96A5-8E9E2990EEDB@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com> <8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org> <CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com> <8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org> <CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com> <07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org> <CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

>> See doc/mgmt-api.txt for the details since btmgmt maps the management interface. In short action 1 means to allow incoming connections.
> 
> Got it. I tried "-a 0" and it returned Invalid Parameters. But anyway,
> "1" is the one I needed.

the documentation clearly says that action 0x00 and 0x02 are only valid for LE addresses. Action 0x01 is valid for BR/EDR and LE addresses.

If anyone wants to implement action 0x00 semantics on BR/EDR, then it requires using Periodic Inquiry. It is possible, but it is not a common use case these days.

Regards

Marcel

