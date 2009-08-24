Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251139257.2950.60.camel@localhost.localdomain>
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
	 <1251139257.2950.60.camel@localhost.localdomain>
Date: Mon, 24 Aug 2009 16:26:30 -0300
Message-ID: <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com>
Subject: Re: sniff mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 24, 2009 at 3:40 PM, Marcel Holtmann<marcel@holtmann.org> wrote=
:
> Hi Luiz,
>
>> It is just me or hci_conn_enter_active_mode will never do what its
>> name suggests. This check will always succeed:
>>
>> =A0 =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto timer;
>
> so conn->power_save is used to disable automatic sniff mode for incoming
> connections. Mainly HID since they manager it by themselves.

Hmm, but this seems to be done for any device regardless of its type.
So for example we start sending/receiving data to a headset it will
triggers hci_conn_enter_active_mode which I thought would exit sniff
mode, right? (yep, I have seem some headset that doesn't leave sniff
mode by their own).

>> But in hci_mode_change_evt whatever mode different than HCI_CM_ACTIVE
>> reset power_save to zero:
>>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE=
_PEND, &conn->pend)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (conn->mode =3D=3D HCI_CM=
_ACTIVE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->power_=
save =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->power_=
save =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> And again, we are not setting the sniff mode. We disable automatic sniff
> mode feature.

It really seems the opposite, like we were disabling the automatic
active mode since this make us to always hit goto timer; while in
sniff mode. Perhaps this is meant for when remote device has been
controlling modes, which sound strange to me since hci_mode_change_evt
is called even when the we actively change the mode, right?
(hci_conn_idle does that)

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
