Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D7CD702E-D9BC-4797-BB6D-C6D861056AA8@holtmann.org>
References: <1438161714-4521-1-git-send-email-jpawlowski@google.com>
	<D7CD702E-D9BC-4797-BB6D-C6D861056AA8@holtmann.org>
Date: Wed, 29 Jul 2015 15:59:54 +0200
Message-ID: <CAD0=r8xj4d1Q3RGDkgH_EgHjec62g8pSiGYasxbvD=KoWc90=A@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] Bluetooth: add HCI_LE_CONNECTING hci_dev flags
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 29, 2015 at 3:56 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jakub,
>
> > This patch adds HCI_LE_CONNECTING flag to hci_dev flags, that will be set
> > when connect attempt is pending. It also uses this flag instead of conn
> > hash lookup where appropriate to check wether connect is in progress.
> >
> > Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> > ---
> > include/net/bluetooth/hci.h | 1 +
> > net/bluetooth/hci_conn.c    | 3 +--
> > net/bluetooth/hci_event.c   | 4 ++++
> > net/bluetooth/hci_request.c | 6 ++----
> > net/bluetooth/mgmt.c        | 2 +-
> > 5 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 7ca6690..4772ff8 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -240,6 +240,7 @@ enum {
> >       HCI_DUT_MODE,
> >       HCI_FORCE_BREDR_SMP,
> >       HCI_FORCE_STATIC_ADDR,
> > +     HCI_LE_CONNECTING,
> >
> >       __HCI_NUM_FLAGS,
> > };
>
> this needs to be added to hci_dev_clear_volatile_flags as well then. HCI_Reset would need to reset this value. And I would actually sort it after HCI_LE_SCAN flag or at least after HCI_LE_SCAN_INTERRUPTED.
>
> The last three are clearly put in an individual block since they are special and should be kept special. They are for debugging and testing purposes.
>
Ok, I fought I'm supposed to add it at end, will fix that

>
> Regards
>
> Marcel
>
