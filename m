Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [A2DP] Incoming connections do not succeed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD81oNa-OhvEXWDUwVttG5SXPw+1+oK0qXY9hudjM0kP2cpFmg@mail.gmail.com>
Date: Tue, 26 Aug 2014 19:08:43 -0700
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <3F6C8060-4B6F-4F18-A0D1-15B6CD7CE512@holtmann.org>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com> <CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com> <CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com> <CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com> <574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org> <CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com> <CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com> <CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com> <CAD81oNYbM2tpSbhdfih1ir2BnszwvOkGBKbOiKG70Gcp6qHVRA@mail.gmail.com> <CAD81oNYAkFvHhFnvjSPjp+Wwnz8haJZjmE3MCuJmtom1FWfL1w@mail.gmail.com> <CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com> <2EF4B6C6-2375-45B7-B1AF-D30C4799AC93@holtmann.org> <CABBYNZK=t=otqjW1B64MwWO8cc9aLs+RovVp=5KFEBbB3zysow@mail.gmail.com> <2854D296-3CCA-4628-90B5-76D03EF2660D@holtmann.org> <CAD81oNb2p5ux2U2vKvSQb8Z2o+gjbZwEh0H4jb4VdEueBDez0A@mail.gmail
 .com> <3775CFA8-F840-440C-AC0E-FC639F542AA6@holtmann.org> <CAD81oNYvSKv0YR8qiDspCCRxXvvq_iLQpUFkc0tio5ZP24ELWg@mail.gmail.com> <CAD81oNa-OhvEXWDUwVttG5SXPw+1+oK0qXY9hudjM0kP2cpFmg@mail.gmail.com>
To: Artem Rakhov <arakhov@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Artem,

>>> please do not top post on this mailing list. It does break the reading thread.
>>> 
>>>> Here is hcitool info:
>>>> 
>>>> BD Address:  10:B7:F6:01:31:ED
>>>> Device Name: Monster Clarity
>>>> LMP Version: 2.1 (0x4) LMP Subversion: 0x189c
>>>> Manufacturer: Cambridge Silicon Radio (10)
>>>> Features page 0: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>> <3-slot packets>
>>>> Features page 1: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
>>>> 
>>>> Label also says Precision Micro Bluetooth Speaker 100.
>>> 
>>> normally all CSR based solutions should just work. Maybe this is just a bad firmware. Are you sure that Connection Pending is really causing the observed problem. It sounds strange to hit that on a CSR based speaker.
>> 
>> I compared the logs from avtest and bluetoothd (attached earlier in
>> this thread). I think the only difference that could matter is this
>> Authorization Pending response.
> 
> I've tested several devices with and without Defer Setup feature enabled.
> 
> Here is a list of devices, which successfully initiate A2DP
> connection, not depending on Defer Setup:
> Creative WP-350 Headset
> MiiKey Rythm
> JBL Micro Wireless
> HMDX Rave
> Plantronics BBfit
> Bose SoundLink Mobile speaker II
> SOL Tracks Air
> Sony MDR-1RBT
> 
> Here is a list of devices, which fail to initiate A2DP connection with
> Defer Setup enabled, but work fine when Defer Setup is disabled:
> Monster Clarity HD
> Motorola S9-HD
> Sennheiser PX210
> 2010 Toyota Prius

are all of these CSR based devices? If so then it sounds like a batch of broken CSR firmware. If not, then the L2CAP test cases might better be extended to have a test case for this. It is dangerous if such a fundamental Bluetooth 1.1 feature is not working correctly.

> There are no devices, which are working with Defer Setup, and not
> working without Defer Setup. So I didn't see any regression.
> 
> As a result, 4 out of 12 devices do not connect as expected with Defer
> Setup enabled. I think we should consider disabling Defer Setup by
> default, at least for audio.

I all cases this is the A2DP signaling channel that causes the problem? It is not the media channel that is required for streaming?

Our real problem is that we need Defer Setup to be able to cleanly reject connections from devices that we do not know and do not want to talk to use. Especially if they are just not authorized to do so.

Maybe we should use the proposal that Luiz had and just disconnect after a timeout and try to establish the connection from our side. That might actually be useful as a workaround. An alternative option is that we delay the connection pending message for some time and give userspace the chance to respond with either read() or close(). That way we would send the correct answer. However that timeout can only be really short since we need to keep the L2CAP signaling working correctly. So it would only work for cases where the daemon has all information to make a decision. If it asks the user, then this is off limits.

That said, Linux 3.17 is allowing us to use a whitelist for BR/EDR that might be useful to mitigate this behavior as well. Unknown devices would be blocked on the ACL level already.

Regards

Marcel

