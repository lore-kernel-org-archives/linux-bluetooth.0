Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960911161055y695933fdjd221ad3b689ae3cf@mail.gmail.com>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet> <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet> <35c90d960911161055y695933fdjd221ad3b689ae3cf@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Tue, 2 Feb 2010 18:15:25 -0800
Message-ID: <35c90d961002021815y2ffd5897jeb7ff6b253e72b69@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 16, 2009 at 10:55 AM, Nick Pelly <npelly@google.com> wrote:
> Hi Marcel,
>
> On Thu, Nov 12, 2009 at 7:52 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Nick,
>>
>>> >> If I understand correctly, conn->power_save prevents the host stack
>>> >> from requesting active mode if it was not the host stack that
>>> >> requested sniff mode.
>>> >>
>>> >> I don't understand the motivation for this. If we have ACL data to
>>> >> send, then it seems like a good idea for the host stack to explicitl=
y
>>> >> request active mode, regardless of the reason that we entered sniff
>>> >> mode.
>>> >>
>>> >> We want to enter active mode more aggressively when setting up SCO
>>> >> connections, to avoid a 5 second delay with certain sniff modes. But
>>> >> the conn->power_save code is getting in the way and doesn't appear t=
o
>>> >> be useful in the first place.
>>> >
>>> > we have discussed this a few times. And if you lock through the code
>>> > history then you see that initially we just took devices out of sniff
>>> > mode if we had to send data. However with HID devices this falls flat=
 on
>>> > its face. They need to stay in control of sniff mode if they initiate=
d
>>> > it. Some of them crash and others just drain the battery. With sniff
>>> > mode you can send small amounts of data even while in sniff and for H=
ID
>>> > that is sometimes used. So the remote side better not interfere.
>>> >
>>> > What we really need is a socket option where we can control this on a
>>> > per socket basis if we take devices out of sniff mode. And one extra
>>> > case might be when we try to establish a SCO channel, because then it=
 is
>>> > clearly not an HID device. However even A2DP has this sort of problem=
s
>>> > sometimes where the stream setup takes time.
>>>
>>> Makes sense. Thanks for the explanation.
>>
>> this means you will be working on a patch for this :)
>>
>>> > Not sure if we have to make SCO setup special. The only reason would =
be
>>> > if there is a case where we don't get an AT command before SCO needs =
to
>>> > be established.
>>>
>>> If you are in-call, and transfer audio from handset to BT headset,
>>> then there is SCO setup without any AT command.
>>
>> Fair enough.
>>
>>> I think for the SCO setup case we would always want to enter active
>>> mode. I could modify enter_active_mode() to take a parameter like 'int
>>> force' that would force us to enter active mode regardless of the
>>> state of power_save, and use this when setting up SCO. What do you
>>> think?
>>
>> Actually when you leave sniff mode, then all bets for the power_save
>> value are off again. So you better set power_save and just call
>> enter_active_mode. Something like this:
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index a975098..e4591e0 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -376,6 +376,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, i=
nt type,
>>
>> =A0 =A0 =A0 =A0if (acl->state =3D=3D BT_CONNECTED &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(sco->state =3D=3D BT_OPE=
N || sco->state =3D=3D BT_CLOSED)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acl->power_save =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_conn_enter_active_mode(acl);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lmp_esco_capable(hdev))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_setup_sync(sco, acl->=
handle);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>>
>> Alternatively we could create hci_conn_force_active_mode() or just
>> implement a proper per socket sniff/active policy.
>>
>> Regards
>>
>> Marcel
>
> Patch submitted to Android tree as:
>
> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommit;h=3D201ac=
2f225a31dffcb05f1db4d609c467c9c694c

Ping.

Nick
