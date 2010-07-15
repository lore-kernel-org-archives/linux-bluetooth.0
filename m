Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTiluu5TW1IqAEJrzH9iO0QbJID1G19pd-7TSZ1sG@mail.gmail.com>
References: <AANLkTinYIezHD8y4D4s9_awxjdqVV2NSp0f6Tmq1FEpa@mail.gmail.com>
	<AANLkTimpe_b4IpgRnTHWctF9XcYnb8vVmUCKGdn0_dKO@mail.gmail.com>
	<AANLkTiluu5TW1IqAEJrzH9iO0QbJID1G19pd-7TSZ1sG@mail.gmail.com>
Date: Thu, 15 Jul 2010 11:46:49 +0300
Message-ID: <AANLkTimrBSHiwdGvJbQLnIB4dVIkUU6GiUFE6OQo-9WF@mail.gmail.com>
Subject: Re: SSP Link key storing issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prabhakaran Chandrasekara M <prvb86@motorola.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 15, 2010 at 9:38 AM, Prabhakaran Chandrasekara M
<prvb86@motorola.com> wrote:
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
>> dbus-hci.c
>> hci_dbus_link_key_notify
>>
>> /* Only store the link key if one of the following is true:
>>      * 1. this is a legacy link key
>>      * 2. this is a changed combination key and there was a previously
>>      *    stored one
>>      * 3. neither local nor remote side had no-bonding as a requirement
>>      * 4. the local side had dedicated bonding as a requirement
>>      * 5. the remote side is using dedicated bonding since in that case
>>      *    also the local requirements are set to dedicated bonding
>>      */

I don;t know exactly which page, but the spec says that when one side
has no-bonding, I guess 3. is about that, then the link key should not
be stored. Also a2dp connection should be using medium security as we
do in bluetoothd (it is the default when using BtIO) then you will got
the link key stored properly.


-- 
Luiz Augusto von Dentz
Computer Engineer
