Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [A2DP] Incoming connections do not succeed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
Date: Mon, 28 Jul 2014 22:29:33 -0700
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com> <CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com> <CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com> <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
To: Artem Rakhov <arakhov@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

> Have tried to connect the speaker to Macbook Pro (OS X, does not use
> BlueZ). For some reason, when speaker initiates the incoming
> connection, it connects via L2CAP to different PSM.
> First, it goes to PSM 0x01 (Service Discovery Protocol), then
> disconnects. Then it connects to 0x03 (RFCOMM) and keeps the
> connection. After that speaker connects to PSM 0x01 again, and drops
> connection.
> And then finally the Mac itself initiates two L2CAP connections to
> speaker, with correct PSM 0x19 (AVDTP). On device with BlueZ L2CAP
> connection goes straight to PSM 0x19.
> 
> Here is a log from Macbook for the first connection to AVDTP:
> [Jul 28 21:06:37.848]  [L2CAP SEND]  Connection Request - PSM: 0x0019
>               Connection Request - PSM: 0x0019
>               Identifier: 0x81
>               Size: 4 (0x0004)
>               PSM: 0x0019 - AVDTP (Audio/Video Distribution Transport
> Protocol).
>               Source CID: 0x0043
>               Channel ID: 0x0001  Length: 0x0008 (08) [ 0B 20 0C 00
> 08 00 01 00 ]
>               00000000: 0800 0100 0281 0400 1900 4300            ..........C.

you know that hcidump and btmon can read Packet Logger files created on OS X. So maybe sending a binary pklg file around might be helpful for anybody looking at the details here.

Regards

Marcel

