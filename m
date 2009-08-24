Return-Path: <cyrus@holtmann.org>
Subject: Re: sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com>
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
	 <1251139257.2950.60.camel@localhost.localdomain>
	 <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 12:33:48 -0700
Message-Id: <1251142428.2950.61.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> It is just me or hci_conn_enter_active_mode will never do what its
> >> name suggests. This check will always succeed:
> >>
> >>       if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
> >>               goto timer;
> >
> > so conn->power_save is used to disable automatic sniff mode for incoming
> > connections. Mainly HID since they manager it by themselves.
> 
> Hmm, but this seems to be done for any device regardless of its type.
> So for example we start sending/receiving data to a headset it will
> triggers hci_conn_enter_active_mode which I thought would exit sniff
> mode, right? (yep, I have seem some headset that doesn't leave sniff
> mode by their own).

I said this before. We need a socket option for L2CAP and RFCOMM that
can trigger leaving sniff mode even if the remote device initiated the
connection.

> >> But in hci_mode_change_evt whatever mode different than HCI_CM_ACTIVE
> >> reset power_save to zero:
> >>
> >>
> >>               if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
> >>                       if (conn->mode == HCI_CM_ACTIVE)
> >>                               conn->power_save = 1;
> >>                       else
> >>                               conn->power_save = 0;
> >>               }
> >
> > And again, we are not setting the sniff mode. We disable automatic sniff
> > mode feature.
> 
> It really seems the opposite, like we were disabling the automatic
> active mode since this make us to always hit goto timer; while in
> sniff mode. Perhaps this is meant for when remote device has been
> controlling modes, which sound strange to me since hci_mode_change_evt
> is called even when the we actively change the mode, right?
> (hci_conn_idle does that)

I am not following.

Regards

Marcel


