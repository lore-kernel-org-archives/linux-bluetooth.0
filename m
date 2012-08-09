Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1344433958.2083.52.camel@aeonflux>
References: <1344411753-10124-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1344411753-10124-3-git-send-email-mikel.astiz.oss@gmail.com>
	<1344433958.2083.52.camel@aeonflux>
Date: Thu, 9 Aug 2012 09:43:56 +0200
Message-ID: <CANT-zCX2UTTjLL1hWNS4sutwvgAmbPtP_4fRZBg26a-eQMC0Lg@mail.gmail.com>
Subject: Re: [RFC v3 2/2] Bluetooth: mgmt: Add device disconnect reason
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Aug 8, 2012 at 3:52 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikel,
>
>> MGMT_EV_DEVICE_DISCONNECTED will now expose the disconnection reason to
>> userland, distinguishing four possible values:
>>
>>       0x00    Reason not known or unspecified
>>       0x01    ACL connection timeout
>>       0x02    ACL connection terminated by local host
>>       0x03    ACL connection terminated by remote host
>
> I think we need to leave ACL out here. Since that is not how we defined
> what a connection is in mgmt terms.
>
>> Note that the local/remote distinction just determines which side
>> terminated the low-level ACL connection, regardless of the disconnection
>> of the higher-level profiles.
>>
>> This can sometimes be misleading and thus must be used with care. For
>> example, some hardware combinations would report a locally initiated
>> disconnection even if the user turned Bluetooth off in the remote side.
>
> Please make sure that this comment makes it also into the API
> description.

I will send an updated version soon, with all your suggestions, along
with the updated userland patch where you can see the API
documentation.

<snip>

>> @@ -1906,12 +1907,29 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>
>>       if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
>>           (conn->type == ACL_LINK || conn->type == LE_LINK)) {
>> -             if (ev->status != 0)
>> +             if (ev->status != 0) {
>
> While at it, turn this into if (ev->status).

I will send a separate patch for this and other similar occurrences.
Let me know if you prefer to squash the change.

Cheers,
Mikel
