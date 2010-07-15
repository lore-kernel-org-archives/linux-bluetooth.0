Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <luiz.dentz@gmail.com>, <prvb86@motorola.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Thu, 15 Jul 2010 11:56:45 +0300
Subject: RE: SSP Link key storing issue
Message-ID: <99B09243E1A5DA4898CDD8B7001114480969964CFC@EXMB04.eu.tieto.com>
References: <AANLkTinYIezHD8y4D4s9_awxjdqVV2NSp0f6Tmq1FEpa@mail.gmail.com>
	<AANLkTimpe_b4IpgRnTHWctF9XcYnb8vVmUCKGdn0_dKO@mail.gmail.com>
	<AANLkTiluu5TW1IqAEJrzH9iO0QbJID1G19pd-7TSZ1sG@mail.gmail.com>
 <AANLkTimrBSHiwdGvJbQLnIB4dVIkUU6GiUFE6OQo-9WF@mail.gmail.com>
In-Reply-To: <AANLkTimrBSHiwdGvJbQLnIB4dVIkUU6GiUFE6OQo-9WF@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>Hi,

>On Thu, Jul 15, 2010 at 9:38 AM, Prabhakaran Chandrasekara M <prvb86@motorola.com> wrote:
> Can some body please explain why the below check is considered while 
> storing link key.
>
>
> On Thu, Jul 15, 2010 at 10:25 AM, Prabhakaran Chandrasekara M 
> <prvb86@motorola.com> wrote:
>> Hello All,
>>
>>  I am facing some problem with SSP pairing.
>> Sometimes Bluez does not store the Authenticated Combination link key 
>> generated during pairing process And found the below code in 
>> dbus-hci.c hci_dbus_link_key_notify
>>
>> /* Only store the link key if one of the following is true:
>>      * 1. this is a legacy link key
>>      * 2. this is a changed combination key and there was a 
>> previously
>>      *    stored one
>>      * 3. neither local nor remote side had no-bonding as a 
>> requirement
>>      * 4. the local side had dedicated bonding as a requirement
>>      * 5. the remote side is using dedicated bonding since in that 
>> case
>>      *    also the local requirements are set to dedicated bonding
>>      */

> don;t know exactly which page, but the spec says that when one side has no-bonding, I guess 3. is about that, then the link key should not be stored. Also a2dp connection should be using medium security as we do in bluetoothd (it is the default when using BtIO) then you will got >the link key stored properly.


In the spec 2.1 is not clearly stated, but it was explained in the errara to the GAP 2.1
https://www.bluetooth.org/errata/errata_view.cfm?errata_id=2460

You can see also spec to core 3.0  in 6.5.3.1 chapter which says

"When the devices that are performing General Bonding both support Secure
Simple Pairing, the Authentication_Requirements parameter should be set to
MITM Protection Not Required - General Bonding unless the security policy of
an available local service requires MITM Protection in which case the
Authentication_Requirements parameter shall be set to MITM Protection
Required - General Bonding. 'No bonding' is used when the device is performing
a Secure Simple Pairing procedure, but does not intend to retain the link
key after the physical link is disconnected."

In general, this is correct behaviour of Bluez.

Thanks,
Waldek