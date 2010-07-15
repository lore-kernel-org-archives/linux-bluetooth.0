Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA305D521EBE@EXDCVYMBSTM005.EQ1STM.local>
References: <AANLkTinYIezHD8y4D4s9_awxjdqVV2NSp0f6Tmq1FEpa@mail.gmail.com>
	<AANLkTimpe_b4IpgRnTHWctF9XcYnb8vVmUCKGdn0_dKO@mail.gmail.com>
	<AANLkTiluu5TW1IqAEJrzH9iO0QbJID1G19pd-7TSZ1sG@mail.gmail.com>
	<AANLkTimrBSHiwdGvJbQLnIB4dVIkUU6GiUFE6OQo-9WF@mail.gmail.com>
	<99B09243E1A5DA4898CDD8B7001114480969964CFC@EXMB04.eu.tieto.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA305D521EBE@EXDCVYMBSTM005.EQ1STM.local>
Date: Thu, 15 Jul 2010 18:06:51 +0530
Message-ID: <AANLkTilZxlxjM1X0yHZ4p2sKq_4lRQdqMAO_E1LeW10N@mail.gmail.com>
Subject: Re: SSP Link key storing issue
From: Prabhakaran Chandrasekara M <prvb86@motorola.com>
To: Par-Gunnar HJALMDAHL <par-gunnar.p.hjalmdahl@stericsson.com>
Cc: Waldemar.Rymarkiewicz@tieto.com, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,



On Thu, Jul 15, 2010 at 5:53 PM, Par-Gunnar HJALMDAHL
<par-gunnar.p.hjalmdahl@stericsson.com> wrote:
> To clarify myself below:
> Next connection would then fail anyway. ->
> Next authenticated connection would then require a new pairing procedure anyway so there is no point in saving the link key.
>
> /P-G Hjalmdahl
>
>
> -----Original Message-----
> From: Par-Gunnar HJALMDAHL
> Sent: den 15 juli 2010 14:11
> To: 'Waldemar.Rymarkiewicz@tieto.com'; luiz.dentz@gmail.com; prvb86@motorola.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: SSP Link key storing issue
>
> Hi,
>
> Basically the reasoning behind all this in the specification is that there is no point in saving the link key on only one side at pairing.
> Next connection would then fail anyway.
> I agree with Waldemar, this is correct behavior by BlueZ.
>
> Best regards,
> Par-Gunnar Hjalmdahl, ST-Ericsson
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Waldemar.Rymarkiewicz@tieto.com
> Sent: den 15 juli 2010 10:57
> To: luiz.dentz@gmail.com; prvb86@motorola.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: SSP Link key storing issue
>
> Hi,
>
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>>Hi,
>
>>On Thu, Jul 15, 2010 at 9:38 AM, Prabhakaran Chandrasekara M <prvb86@motorola.com> wrote:
>> Can some body please explain why the below check is considered while
>> storing link key.
>>
>>
>> On Thu, Jul 15, 2010 at 10:25 AM, Prabhakaran Chandrasekara M
>> <prvb86@motorola.com> wrote:
>>> Hello All,
>>>
>>>  I am facing some problem with SSP pairing.
>>> Sometimes Bluez does not store the Authenticated Combination link key
>>> generated during pairing process And found the below code in
>>> dbus-hci.c hci_dbus_link_key_notify
>>>
>>> /* Only store the link key if one of the following is true:
>>>      * 1. this is a legacy link key
>>>      * 2. this is a changed combination key and there was a
>>> previously
>>>      *    stored one
>>>      * 3. neither local nor remote side had no-bonding as a
>>> requirement
>>>      * 4. the local side had dedicated bonding as a requirement
>>>      * 5. the remote side is using dedicated bonding since in that
>>> case
>>>      *    also the local requirements are set to dedicated bonding
>>>      */
>
>> don;t know exactly which page, but the spec says that when one side has no-bonding, I guess 3. is about that, then the link key should not be stored. Also a2dp connection should be using medium security as we do in bluetoothd (it is the default when using BtIO) then you will got >the link key stored properly.
>
>
> In the spec 2.1 is not clearly stated, but it was explained in the errara to the GAP 2.1
> https://www.bluetooth.org/errata/errata_view.cfm?errata_id=2460
>

This errata is very clear that if a device sets auth_requirement as
"No Bonding" then it will not store the link key. Thanks for the
information.
But I am not clear that why Bluez sets Auth_requirement as "No
Bonding" during a a2dp connection. As Luiz mentioned, the Security
level is set to medium. I am analyzing the logs, I will attach the
logs in my next mail.
> You can see also spec to core 3.0  in 6.5.3.1 chapter which says

>
> "When the devices that are performing General Bonding both support Secure
> Simple Pairing, the Authentication_Requirements parameter should be set to
> MITM Protection Not Required - General Bonding unless the security policy of
> an available local service requires MITM Protection in which case the
> Authentication_Requirements parameter shall be set to MITM Protection
> Required - General Bonding. 'No bonding' is used when the device is performing
> a Secure Simple Pairing procedure, but does not intend to retain the link
> key after the physical link is disconnected."
>
> In general, this is correct behaviour of Bluez.
>
> Thanks,
> Waldek--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks,
Prabhakaran.
