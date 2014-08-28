Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+pZBBZFEWeTMkHrxyp+P3LqA5opnaLOovxxHzme2kM=Q@mail.gmail.com>
References: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
	<CABBYNZ+zRKzv4yTc8M2Fi0eN6gC921b9zaey5FKGVq_bJJueBg@mail.gmail.com>
	<CAD81oNbjd3-Y_7C=75TfBP0oXjA3eFWbezsD8nROUrseUJZNhg@mail.gmail.com>
	<CAD81oNZkRk-KFcE1bkj8TWiqe7dyVjHJADicT-f5KEkKtcnbyA@mail.gmail.com>
	<574DE1E1-7A53-4629-88FC-7164EC1880AA@holtmann.org>
	<CAD81oNY41-8DhJCOetLa_TCrPLBeiJFHQJ7TxawydwQ5S_Lmwg@mail.gmail.com>
	<CABBYNZLEDBFa-wV5L5Pfi-PzA877PxSrktsVLpzCRuQ4nu1eKQ@mail.gmail.com>
	<CAD81oNZYeobbhMawvhrjTFSTY-aqEXYh9x3aTSOoH8u1Y6nHDQ@mail.gmail.com>
	<CAD81oNYbM2tpSbhdfih1ir2BnszwvOkGBKbOiKG70Gcp6qHVRA@mail.gmail.com>
	<CAD81oNYAkFvHhFnvjSPjp+Wwnz8haJZjmE3MCuJmtom1FWfL1w@mail.gmail.com>
	<CABBYNZKQy9Q37Fe-E+Qf90c-waeWB+yk-Mnk+VAwqN7cTTfDQA@mail.gmail.com>
	<2EF4B6C6-2375-45B7-B1AF-D30C4799AC93@holtmann.org>
	<CABBYNZK=t=otqjW1B64MwWO8cc9aLs+RovVp=5KFEBbB3zysow@mail.gmail.com>
	<2854D296-3CCA-4628-90B5-76D03EF2660D@holtmann.org>
	<3775CFA8-F840-440C-AC0E-FC639F542AA6@holtmann.org>
	<CAD81oNYvSKv0YR8qiDspCCRxXvvq_iLQpUFkc0tio5ZP24ELWg@mail.gmail.com>
	<CAD81oNa-OhvEXWDUwVttG5SXPw+1+oK0qXY9hudjM0kP2cpFmg@mail.gmail.com>
	<3F6C8060-4B6F-4F18-A0D1-15B6CD7CE512@holtmann.org>
	<CAD81oNZd=v16fPG=KSw2aP=7ewPv48X2dVXv2-XO+_6bJKHb2A@mail.gmail.com>
	<CABBYNZ+pZBBZFEWeTMkHrxyp+P3LqA5opnaLOovxxHzme2kM=Q@mail.gmail.com>
Date: Thu, 28 Aug 2014 14:19:40 +0300
Message-ID: <CABBYNZKGDB9-VwHjpajas2TbuMaTyRaun3K5NyueypzTNMfuug@mail.gmail.com>
Subject: Re: [A2DP] Incoming connections do not succeed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Artem Rakhov <arakhov@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Aug 27, 2014 at 9:34 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Artem, Marcel,
>
> On Wed, Aug 27, 2014 at 9:33 AM, Artem Rakhov <arakhov@chromium.org> wrot=
e:
>> On Tue, Aug 26, 2014 at 7:08 PM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>>> Hi Artem,
>>>
>>>>>> please do not top post on this mailing list. It does break the readi=
ng thread.
>>>>>>
>>>>>>> Here is hcitool info:
>>>>>>>
>>>>>>> BD Address:  10:B7:F6:01:31:ED
>>>>>>> Device Name: Monster Clarity
>>>>>>> LMP Version: 2.1 (0x4) LMP Subversion: 0x189c
>>>>>>> Manufacturer: Cambridge Silicon Radio (10)
>>>>>>> Features page 0: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>>>>> <3-slot packets>
>>>>>>> Features page 1: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
>>>>>>>
>>>>>>> Label also says Precision Micro Bluetooth Speaker 100.
>>>>>>
>>>>>> normally all CSR based solutions should just work. Maybe this is jus=
t a bad firmware. Are you sure that Connection Pending is really causing th=
e observed problem. It sounds strange to hit that on a CSR based speaker.
>>>>>
>>>>> I compared the logs from avtest and bluetoothd (attached earlier in
>>>>> this thread). I think the only difference that could matter is this
>>>>> Authorization Pending response.
>>>>
>>>> I've tested several devices with and without Defer Setup feature enabl=
ed.
>>>>
>>>> Here is a list of devices, which successfully initiate A2DP
>>>> connection, not depending on Defer Setup:
>>>> Creative WP-350 Headset
>>>> MiiKey Rythm
>>>> JBL Micro Wireless
>>>> HMDX Rave
>>>> Plantronics BBfit
>>>> Bose SoundLink Mobile speaker II
>>>> SOL Tracks Air
>>>> Sony MDR-1RBT
>>>>
>>>> Here is a list of devices, which fail to initiate A2DP connection with
>>>> Defer Setup enabled, but work fine when Defer Setup is disabled:
>>>> Monster Clarity HD
>>>> Motorola S9-HD
>>>> Sennheiser PX210
>>>> 2010 Toyota Prius
>>>
>>> are all of these CSR based devices? If so then it sounds like a batch o=
f broken CSR firmware. If not, then the L2CAP test cases might better be ex=
tended to have a test case for this. It is dangerous if such a fundamental =
Bluetooth 1.1 feature is not working correctly.
>>
>> Yes, all these devices are CSR-based.
>
> Well I have access to none of those which is kind nice.
>
>>>> There are no devices, which are working with Defer Setup, and not
>>>> working without Defer Setup. So I didn't see any regression.
>>>>
>>>> As a result, 4 out of 12 devices do not connect as expected with Defer
>>>> Setup enabled. I think we should consider disabling Defer Setup by
>>>> default, at least for audio.
>>>
>>> I all cases this is the A2DP signaling channel that causes the problem?=
 It is not the media channel that is required for streaming?
>>
>> Yes, exactly same scenario. The very first connection fails from
>> speaker to source, which goes to AVDTP (PSM 25).
>
> There are some other things to experiment, there seems to be possible
> to use ERTM nowadays, for signalling only, and while this does not
> exactly change in any way how we use authorization pending response it
> perhaps make a difference in terms of timing, if we are lucky,
> otherwise we can go with whitelist and retry.
>
>>> Our real problem is that we need Defer Setup to be able to cleanly reje=
ct connections from devices that we do not know and do not want to talk to =
use. Especially if they are just not authorized to do so.
>>>
>>> Maybe we should use the proposal that Luiz had and just disconnect afte=
r a timeout and try to establish the connection from our side. That might a=
ctually be useful as a workaround. An alternative option is that we delay t=
he connection pending message for some time and give userspace the chance t=
o respond with either read() or close(). That way we would send the correct=
 answer. However that timeout can only be really short since we need to kee=
p the L2CAP signaling working correctly. So it would only work for cases wh=
ere the daemon has all information to make a decision. If it asks the user,=
 then this is off limits.
>>>
>>> That said, Linux 3.17 is allowing us to use a whitelist for BR/EDR that=
 might be useful to mitigate this behavior as well. Unknown devices would b=
e blocked on the ACL level already.
>
> If whitelist for classic is to be based on the trusted list, which I
> assume it should be, then the kernel could accept the connection right
> away but then we need some mechanism to query if the whitelist has
> taken effect or maybe it is fine already since bt_io_accept does the
> following:
>
> if (!(pfd.revents & POLLOUT)) {
>     if (read(sock, &c, 1) < 0) {
>         ERROR_FAILED(err, "read", errno);
>         return FALSE;
>     }
> }
>
> So POLLOUT seems to be for checking if the socket has been accepted
> already, in case we have a older kernel we can only retry if
> authorization succeeds but that will probably only happen if the
> device happens to be trusted otherwise it will trigger the agent for
> user to authorize and it more likely the device will disconnect before
> the user can react cancelling the authorization.

I was checking how whitelist actually works currently and in fact it
is not based on trusted list but on persistency, but we could use
action 2 for BREDR once they are marked as trusted but perhaps you
guys had something else in mind while designing Add Device command. If
we can't really reuse action 2, or have a dedicated action for trusted
devices, then Im afraid it won't help in this specific problem.


--=20
Luiz Augusto von Dentz
