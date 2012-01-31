Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Jan 2012 15:02:43 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RESEND 1/3] Bluetooth: Use cancel_work instead of
 cancel_work_sync
Message-ID: <20120131130242.GB7660@aemeltch-MOBL1>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Jan 31, 2012 at 09:31:45AM -0300, Andre Guedes wrote:
> > -       cancel_delayed_work_sync(&conn->disc_work);
> > +       cancel_delayed_work(&conn->disc_work);
> 
> I'm afraid we must use _sync variant here. disc_work is not supposed to
> be running after hci_conn is deleted.
> 
> BTW, I believe we already addressed this issue in patches [PATCH 1/2]
> Bluetooth: Fix potential deadlock and [PATCH 2/2] Bluetooth: Remove
> unneeded locking. These patches are now pushed upstream. Could you

I will check those patches from upstream and let you know.

Best regards 
Andrei Emeltchenko 
