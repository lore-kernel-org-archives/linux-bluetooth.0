Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251142428.2950.61.camel@localhost.localdomain>
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
	 <1251139257.2950.60.camel@localhost.localdomain>
	 <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com>
	 <1251142428.2950.61.camel@localhost.localdomain>
Date: Mon, 24 Aug 2009 17:58:22 -0300
Message-ID: <2d5a2c100908241358m26c615aao1a384d9d954bf713@mail.gmail.com>
Subject: Re: sniff mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Aug 24, 2009 at 4:33 PM, Marcel Holtmann<marcel@holtmann.org> wrote=
:
>> It really seems the opposite, like we were disabling the automatic
>> active mode since this make us to always hit goto timer; while in
>> sniff mode. Perhaps this is meant for when remote device has been
>> controlling modes, which sound strange to me since hci_mode_change_evt
>> is called even when the we actively change the mode, right?
>> (hci_conn_idle does that)
>
> I am not following.

Perhaps it is just me, but I don't see any attempt to detect which
part has initiated the connection, so regardless of who has been the
initiator, on any mode change different than active we will reset the
power_save to 0 which will prevent any attempt to leave sniff mode.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
