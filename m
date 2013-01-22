Return-Path: <cyrus@holtmann.org>
Message-ID: <50FECE05.6020804@timomueller.eu>
Date: Tue, 22 Jan 2013 18:36:05 +0100
From: =?UTF-8?B?VGltbyBNw7xsbGVy?= <mail@timomueller.eu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [RFC] Bluetooth: Fix missing MITM protection when being responding
 LM
References: <1358789748-318-1-git-send-email-mail@timomueller.eu>  <20130122081320.GA27138@x220> <1358851002.7365.11.camel@aeonflux>
In-Reply-To: <1358851002.7365.11.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Hi Marcel,

Marcel Holtmann wrote, On 22.01.2013 11:36:
> Hi Johan,
>
>>> A MITM protected SSP associaton model can be used for pairing if both
>>> local and remote IO capabilities are set to something other than
>>> NoInputNoOutput.
>>>
>>> With these IO capabilities a MITM protected SSP association model is
>>> used if we are initiating the pairing process (initiating LM).
>>>
>>> When responding to a pairing request - remote device is the initiating
>>> LM - the pairing should also be proteced against MITM attacks.
>>>
>>> Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
>>> ---
>>> When we were testing the iPhone 5 we noticed that the association
>>> model changes depending on which side initiates the pairing. For
>>> example if we paired from the phone "Just Works" was used while if the
>>> phone was the responding LM a "Numeric Comparison" was used instead.
>>>
>>> We'd like to enforce MITM protection in our cars whenever possible.
>>> That is why we want to set the MITM protection even when being the
>>> responding LM. The patch proposes this policy as the default approach.
>>>
>>> Expected SSP accociation model:
>>> |-------------------------------------------|
>>> |  Device          |  SSP assocation model  |
>>> |===========================================|
>>> |  KeyboardDisplay |  Numeric Comparison    |
>>> | ------------------------------------------|
>>> |  NoInputNoOutput |  Just Works            |
>>> | ------------------------------------------|
>>> |  KeyboardOnly    |  Passkey Entry         |
>>> |-------------------------------------------|
>>>
>>> Tested Devices:
>>>    KeyboardDisplay:
>>>      iPhone 4 (iOS4), iPhone 5 (iOS6), Nokia N9, HTC One S,
>>>      Samsung Galaxy (CM 10.1), Nexus 4, Nokia 6313 Classic,
>>>      BlueZ 5 - Simple Agent
>>>
>>>    NoInputNoOutput:
>>>      BlueZ 5 - Simple Agent
>>>
>>>    KeyboardOnly:
>>>      Logitech Keyboard Case, BlueZ 5 - Simple Agent
>>>
>>> I've also tested this patch with the following kernels:
>>>    3.8-rc4
>>>    3.4
>>>
>>> Best regards,
>>> 	 Timo
>>>
>>>   net/bluetooth/hci_conn.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index 25bfce0..806583b 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -357,11 +357,15 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
>>>   	conn->type  = type;
>>>   	conn->mode  = HCI_CM_ACTIVE;
>>>   	conn->state = BT_OPEN;
>>> -	conn->auth_type = HCI_AT_GENERAL_BONDING;
>>>   	conn->io_capability = hdev->io_capability;
>>>   	conn->remote_auth = 0xff;
>>>   	conn->key_type = 0xff;
>>>
>>> +	if (hdev->io_capability == 0x03)
>>> +		conn->auth_type = HCI_AT_GENERAL_BONDING;
>>> +	else
>>> +		conn->auth_type = HCI_AT_GENERAL_BONDING_MITM;
>>> +
>>>   	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
>>>   	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
>>
>> The question that could equally be asked is why does iOS *not* set the
>> MITM flag when initiating pairing to a remote device. If it did this
>> issue would not exist.
>
> because iOS does not support SIM Access Profile. Outside of SIM Access,
> there is really no need to support high security.
>
> The difference between medium security and high security is really only
> the man-in-the-middle protection. From an encryption and link key
> strength point of view they are identical. Both link keys are P-192
> derived and the encryption cipher is still E0.
>
>> Since the over all sequence of the IO capability negotiation with iOS devices
>> when we're on the acceptor side might be a bit unclear to people by just
>> reading your commit message and patch I'll provide here a HCI trace of it:
>>
>>   > HCI Event: IO Capability Response (0x32) plen 9
>>           Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
>>           IO capability: DisplayYesNo (0x01)
>>           OOB data: Authentication data not present (0x00)
>>           Authentication: General Bonding - MITM not required (0x04)
>>   > HCI Event: IO Capability Request (0x31) plen 6
>>           Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
>>   < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
>>           Address: 04:F7:E4:xx:xx:xx (OUI 04-F7-E4)
>>           IO capability: DisplayYesNo (0x01)
>>           OOB data: Authentication data not present (0x00)
>>           Authentication: General Bonding - MITM not required (0x04)
>>
>> Basically the BlueZ side has so far given the remote initiator the
>> choice whether to do just-works or not. However, I do agree that it's
>> good to strive for a best-possible security in the pairing (within the
>> limits of the available IO capabilities) so setting the MITM flag on our
>> side should be fine.
>
> This is still something we need to think about carefully. I am not sure
> we should just always be doing this. This might actually be better
> solved with a sysfs option or a mgmt command to pick different behavior.
>
> Since this is General Bonding and not Dedicated Bonding, I am not
> convinced that this is a good idea.
>

The BT spec says for both bonding types "parameter *should* (meaning 
it's recommended to) be set to MITM Protection Not Required" if 
initiator and responder support SSP. For dedicated bonding BlueZ is 
already requiring MITM anyway (if possible). I think it would be good to 
follow this approach also with general bonding.

Influencing the behaviour for general bonding with a mgmt command could 
be an alternative. I will try to add this and send the proposal to the 
mailing list.

>> The one thing that I'd still consider improving is to make the setting
>> of the MITM flag also dependent on the remote IO capability and not just
>> the local one, since we do know the remote one before we need to give
>> our own value when we are on the acceptor side of the pairing. Thoughts?
>
> This is a minimum requirement that we check the remote IO capabilities
> here. Since there is no point in trying MITM protection if the other
> side has no capabilities to ever create such a key.

So instead of setting the default association model according to the 
local IO capabilities, the hci_get_auth_req method could be modified.
For general bonding the method would figure out the MITM requirement 
analogous to the if-block for dedicated bonding. (With the mgmt command, 
this would only be done when MITM is required.)

>
> I would be also curious if we still can qualify our own behavior and not
> end up with cases where we can't because we have no way to trigger it.
>
> Regards
>
> Marcel

Best regards,
Timo
