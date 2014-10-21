Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org>
References: <CAAJw_ZuK6SUy22R133CezsqoU4+dTzxmsipBAp7rCvYBo+zrxw@mail.gmail.com>
	<8BA7CD92-B061-41CE-BD43-7E1B7CD1DF6A@holtmann.org>
	<CAAJw_ZsCeWWoFvdm1Sid6xSDGawp8RaqP07TM1Q2CvSF8DxU=w@mail.gmail.com>
	<8940108C-6C27-49E3-80C8-8983F32D6F55@holtmann.org>
	<CAAJw_ZvrynW0W6fE21ieG+KUwWr_g7-9kDonKYT3ZoEi3Nntiw@mail.gmail.com>
	<07E0A5D2-1E7E-4D89-A8A8-F87E643882A0@holtmann.org>
Date: Tue, 21 Oct 2014 13:46:28 +0800
Message-ID: <CAAJw_ZshxjeK5N3wcFn5cCUZJ0iKVcpFeDUAoijh7JZiweGjqg@mail.gmail.com>
Subject: Re: how to set PSCAN mode in .conf?
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 21, 2014 at 2:03 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> See doc/mgmt-api.txt for the details since btmgmt maps the management interface. In short action 1 means to allow incoming connections.

Marcel,

Got it. I tried "-a 0" and it returned Invalid Parameters. But anyway,
"1" is the one I needed.

> Mixing btmgmt and hciconfig is not a good idea. hciconfig is for all style APIs and btmgmt is for new mgmt interfaces. For example bluetoothd only uses the mgmt interface. So my advice is to just run bluetoothd and then use the D-Bus command to make it discoverable. That will always work correctly and still is as you have seen by running bluetoothctl.
>
> It is like this kernel -> mgmt -> bluetoothd -> D-Bus -> bluetoothctl. And you can replace bluetoothctl with a Python script or your own code.

Great advice. Thank you for sharing.

Jeff.
