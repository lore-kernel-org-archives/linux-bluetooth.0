Return-Path: <cyrus@holtmann.org>
Message-ID: <1328022697.1955.217.camel@aeonflux>
Subject: Re: [RESEND 1/3] Bluetooth: Use cancel_work instead of
 cancel_work_sync
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 31 Jan 2012 07:11:37 -0800
In-Reply-To: <20120131130242.GB7660@aemeltch-MOBL1>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
	 <20120131130242.GB7660@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > -       cancel_delayed_work_sync(&conn->disc_work);
> > > +       cancel_delayed_work(&conn->disc_work);
> > 
> > I'm afraid we must use _sync variant here. disc_work is not supposed to
> > be running after hci_conn is deleted.
> > 
> > BTW, I believe we already addressed this issue in patches [PATCH 1/2]
> > Bluetooth: Fix potential deadlock and [PATCH 2/2] Bluetooth: Remove
> > unneeded locking. These patches are now pushed upstream. Could you
> 
> I will check those patches from upstream and let you know.

crap, I just acked these.

Johan, forget about my acks and just ignore them. Lets wait until we get
a clean new series.

Regards

Marcel


