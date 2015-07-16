Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <394090105.824821437026772897.JavaMail.weblogic@ep2mlwas03a>
References: <394090105.824821437026772897.JavaMail.weblogic@ep2mlwas03a>
Date: Thu, 16 Jul 2015 11:07:14 +0300
Message-ID: <CABBYNZKADu_hB2cSUJeYzbSESj3Fw8EbqA++tXe4=X3B_kCMng@mail.gmail.com>
Subject: Re: Re: [Request] Clarification related to pairing in a particular scenario
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: nagaraj.dr@samsung.com
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	SYAM SIDHARDHAN <s.syam@samsung.com>,
	RAKESH MK <rakesh.mk@samsung.com>,
	Chan-yeol Park <chanyeol.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 16, 2015 at 9:06 AM, Nagaraj D R <nagaraj.dr@samsung.com> wrote:
> Hello Luiz,
>
>>Hi,
>
>>On Thu, Jul 9, 2015 at 9:46 AM, Nagaraj D R wrote:
>>> Hello all,
>>> could someone please clarify my doubt related to the concept of pairing in a particular scenario
>>>
>>> If a remote device having no I/O capability (also authentication : general bonding, and  No MITM protection)
>>>sent a pairing request to our local device(DUT running with the bluez stack), local device stack auto accept
>>> the pairing request even though local device has I/O capability
>>>
>>> Is the Behavior of auto-accepting the pairing request justified?
>>> -- According to the specification "From the Bluetooth Core Specification 4.1 page 1958:
>>>  "if both devices have set the Authentication_Requirements parameter to one of the MITM
>>>   Protection Not Required options, authentication stage 1 shall function as if both devices
>>>   set their IO capabilities to  DisplayOnly (e.g., Numeric comparison with automatic confirmation on both devices)"
>>
>>There is a more precise answer to this in:
>>
>>BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part C]
>>page 323 Table 5.7: IO Capability Mapping to Authentication Stage 1
>>
>>So if we rule No MITM shall be treated as DisplayOnly it would fall
>>into the very first case described in that table:
>>
>>'Numeric Comparison with automatic confirmation on both devices'.
> Yes, this would be the case when "both the device" announce NO MITM Protection.
> But my question is "why does the local device (bluez) sets the Local MITM to "NO MITM" even though local device has
> capability of carrying out MITM protection. Example Phone.

Because MITM requirement cannot be meet with NoInputNoOutput, also
both A2DP and HFP do not required MITM thus we proceed without it.

> The point I'm getting at is, "For any hacking device, it is easy to get paired with local device by setting its I/O capability
> to NO_INPUT_OUTPUT and MITM flag set to NO_MITM_PROTECTION."
> Example is : DUT (Phone running with bluez stack) has hosted a HFP-AG and A2DP-SOURCE profiles. If a remote
> device (an Headset which is trying to connect to previously connected device, i.e our local device DUT) does pairing attempt
> because previous link key is removed in DUT. DUT will get paired silently without notifying user-space/application and
> remote device will get access to HFP and A2DP profiles

In order to be able to do this you need the following:

- Be discoverable otherwise the remote device can't even connect to you.
- Automatically trust any device that is paired thus any connection
from the device is automatically authorized.

Your argument perhaps would work in case of existing device gets
repaired without letting the user know, in that case we could have
malicious attacker that pretend to be some device overwriting and
existing link-key and gain access to the any profile if trusted flag
was set. For new devices this will not be the case because they are
not trusted by default so the user will need to authorize it first
before it gain access to anything.

> How about giving User_space a chance to confirm the pairing, if local device capability is at least one of the
> "output only" "Input only" or "InputOutput" irrespective of the remote MITM and I/O capability?
> Reason being, user_space application gets the flexibility of auto accepting or notifying the user (for confirmation) about ongoing pairing
> request.
> In the case of "output only" : user_spcae application will get flexibility in enforcing pairing to those device which is either "InputOnly" or "InputOutput"
> In the case of "Input only" : user_space application will get flexibility in enforcing pairing to those device which is "displayonly" or "InputOutput"
> In the case of "InputOutput" : user_space application will get flexibility in including "user action" for accepting the pairing.
>
> If this violates spec in any case, then we shall propose correction in spec as well.

I guess you want to disregard DisplayOnly for No MITM protection, but
I think this is a fundamental for using Just Works pairing since
otherwise you will end up one side authentication being triggered but
not used just to inform the user of a new pairing. Also note that by
the time pairing happens we still have no idea what profiles the
remote device supports so it is perhaps too soon to warn the user
about a new pairing, you should instead use the authorization for that
and give the user the option to trust/block the device in the first
connection.

>>>  Local device had set the "NO MITM protection required" based on the remote authentication and capabilities.
>>>   Is the behavior of over-riding local device MITM capability necessary?
>>>
>>> In case of local device initiating a connection to the remote device, auto accept from the stack is acceptable
>>> but in case of remote initiated connection, auto-accept will cause user inconvenience, Isn't it?
>>>
>>> I have tested the similar scenario with the device having bluedroid stack, here we get a authorization popup,
>>> action on which will complete the pairing and connection. i.e auto-pairing is not done in stack
>>
>>I guess it is because it does not take into account that No MITM shall
>>be treated as DisplayOnly.
>>
>>> May be we all have the following query,
>>>
>>>
>> >Regards
>>> Nagaraj D R
>>
> --
>>Luiz Augusto von Dentz
>
> Regards
> Nagaraj D R



-- 
Luiz Augusto von Dentz
