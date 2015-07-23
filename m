Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150723081750.GA7358@t440s.lan>
References: <1437564577-4207-1-git-send-email-jpawlowski@google.com>
	<1437564577-4207-2-git-send-email-jpawlowski@google.com>
	<20150723081750.GA7358@t440s.lan>
Date: Thu, 23 Jul 2015 10:30:24 +0200
Message-ID: <CAD0=r8yJ1ho4swb8icyzdD+umkQEarVM2o35hre5gEKmE_oSjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: Enable new connection establishment procedure.
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jul 23, 2015 at 10:17 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Jakub,
>
> On Wed, Jul 22, 2015, Jakub Pawlowski wrote:
> > @@ -3564,9 +3564,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> >                */
> >               hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
> >
> > -             conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
> > -                                   sec_level, HCI_LE_CONN_TIMEOUT,
> > -                                   HCI_ROLE_MASTER);
> > +             conn = hci_add_to_sock_conn_whitelist(hdev, &cp->addr.bdaddr,
> > +                                                   addr_type, sec_level,
> > +                                                   HCI_LE_CONN_TIMEOUT,
> > +                                                   HCI_ROLE_MASTER);
>
> The purpose we're introducing this passive scanning functionality is so
> that we have a fresh RPA for the remote device. The way we know that a
> new RPA matches the remote device is by checking against an IRK. If the
> user is calling pair_device it means we don't have an IRK, so in this
> case it seems pointless to me to start passive scanning (not to mention
> that typically paired device is called straight after stopping an active
> scan).


So right now we start scan no matter what kind of address was
provided, it can even be static address, that's how Marcel wanted it
to be in one of his comments (
http://article.gmane.org/gmane.linux.bluez.kernel/62704 ) :

" In addition, I do not think it makes a difference if you are an RPA
or not. Just run through our background
scanning for all connection attempts. This has the advantage that now
simultaneous connection attempts
via L2CAP connect() would not have to wait for each other."

Probably keeping last time when device was seen and choosing what to
do might be good option, but maybe for future improvements, not base
patch ?


>
> Johan
