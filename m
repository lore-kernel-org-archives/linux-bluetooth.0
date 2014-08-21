Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [A2DP] Incoming connections do not succeed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD81oNb2p5ux2U2vKvSQb8Z2o+gjbZwEh0H4jb4VdEueBDez0A@mail.gmail.com>
Date: Thu, 21 Aug 2014 15:24:27 -0500
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <3775CFA8-F840-440C-AC0E-FC639F542AA6@holtmann.org>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com> <CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com> <CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com> <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com> <574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org> <CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com> <CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com> <CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com> <CAD81oNYbM2tpSbhdfih1ir2BnszwvOkGBKbOiKG70Gcp6qHVRA@mail.gmail.com> <CAD81oNYAkFvHhFnvjSPjp+Wwnz8haJZjmE3MCuJmtom1FWfL1w@mail.gmail.com> <CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com> <2EF4B6C6-2375-45B7-B1AF-D30C4799AC93@holtmann.org> <CABBYNZK=t=otqjW1B64MwWO8cc9aLs+RovVp=5KFEBbB3zysow@mail.gmail.com> <2854D296-3CCA-4628-90B5-76D03EF2660D@holtmann.org> <CAD81oNb2p5ux2U2vKvSQb8Z2o+gjbZwEh0H4jb4VdEueBDez0A@mail.gmail
 .com>
To: Artem Rakhov <arakhov@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

please do not top post on this mailing list. It does break the reading thread.

> Here is hcitool info:
> 
> BD Address:  10:B7:F6:01:31:ED
> Device Name: Monster Clarity
> LMP Version: 2.1 (0x4) LMP Subversion: 0x189c
> Manufacturer: Cambridge Silicon Radio (10)
> Features page 0: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> <3-slot packets>
> Features page 1: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
> 
> Label also says Precision Micro Bluetooth Speaker 100.

normally all CSR based solutions should just work. Maybe this is just a bad firmware. Are you sure that Connection Pending is really causing the observed problem. It sounds strange to hit that on a CSR based speaker.

Regards

Marcel

