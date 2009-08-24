Return-Path: <cyrus@holtmann.org>
Subject: Re: sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100908241358m26c615aao1a384d9d954bf713@mail.gmail.com>
References: <2d5a2c100908241126k6cf31de0s282c0f360b6948ec@mail.gmail.com>
	 <1251139257.2950.60.camel@localhost.localdomain>
	 <2d5a2c100908241226y978afd2n44d69b7d27677c13@mail.gmail.com>
	 <1251142428.2950.61.camel@localhost.localdomain>
	 <2d5a2c100908241358m26c615aao1a384d9d954bf713@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 14:12:31 -0700
Message-Id: <1251148351.2950.71.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> It really seems the opposite, like we were disabling the automatic
> >> active mode since this make us to always hit goto timer; while in
> >> sniff mode. Perhaps this is meant for when remote device has been
> >> controlling modes, which sound strange to me since hci_mode_change_evt
> >> is called even when the we actively change the mode, right?
> >> (hci_conn_idle does that)
> >
> > I am not following.
> 
> Perhaps it is just me, but I don't see any attempt to detect which
> part has initiated the connection, so regardless of who has been the
> initiator, on any mode change different than active we will reset the
> power_save to 0 which will prevent any attempt to leave sniff mode.

actually it is not based on who initiated the connection, it is based on
who initiated the sniff mode:

	if (conn->mode == HCI_CM_ACTIVE)
		conn->power_save = 1;
	else
		conn->power_save = 0;

If we are back to active mode, then reset power_save and trigger
automatic sniff-mode else disable it.

Regards

Marcel


