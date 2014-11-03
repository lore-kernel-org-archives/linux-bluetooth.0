Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8ypbdcaFJYMHuOsrZx48G0FjmWVvUytg0ERevCHdgdc4Q@mail.gmail.com>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
	<7D190559-F7EA-4A3B-BF1F-EB53D1715049@holtmann.org>
	<CAD0=r8ypbdcaFJYMHuOsrZx48G0FjmWVvUytg0ERevCHdgdc4Q@mail.gmail.com>
Date: Mon, 3 Nov 2014 09:53:21 -0800
Message-ID: <CAD0=r8z1oAdhTMFRoLnukNfr-AMwrBB5pEdZK17Mt6BK6+u5kw@mail.gmail.com>
Subject: Fwd: [PATCH v2 1/4] add restart_le_scan
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Nov 2, 2014 at 11:42 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Jakub,
>
> the patch subject needs to start with Bluetooth:

I'll send fixed path today.
>
>
> > Currently there is no way to restart le scan. It's needed in
> > preparation for new service scan method. The way it work: it disable,
> > and then enable le scan on controller. During this restart special flag
> > is set to make sure we won't remove disable scan work from workqueue.
> >
> > Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> > ---
> > include/net/bluetooth/hci.h      |  1 +
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_core.c         | 42 +++++++++++++++++++++++++++++++++=
+++++++
> > net/bluetooth/hci_event.c        |  9 ++++++---
> > 4 files changed, 51 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 6e8f249..b15d240 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -194,6 +194,7 @@ enum {
> >       HCI_FAST_CONNECTABLE,
> >       HCI_BREDR_ENABLED,
> >       HCI_LE_SCAN_INTERRUPTED,
> > +     HCI_LE_SCAN_RESTARTING,
> > };
> >
> > /* A mask for the flags that are supposed to remain when a reset happen=
s
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index b8685a7..3c585885 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -334,6 +334,7 @@ struct hci_dev {
> >       unsigned long           dev_flags;
> >
> >       struct delayed_work     le_scan_disable;
> > +     struct delayed_work     le_scan_restart;
>
> So I wonder if we need le_scan_restart delayed_work here. We might be abl=
e to just put that into le_scan_disable one using the HCI_LE_SCAN_RESTART f=
lag.


When you start regular scan or service scan, you schedule
le_scan_disable to take place in around 5-10 seconds to finish scan
(it depends on kind of scan, and it's DISCOV_LE_TIMEOUT, or
hdev->discov_interleaved_timeout)
During those 5-10 seconds we need to restart the scan multiple times.
If we'll try to queue the same work again, that would not work because
of the way queue_delayed_work works. We need to have a different
delayed_work to achieve that, that's why I introduced le_scan_restart.

Also it's possible to have situation when the scan is finishing, and
we call le_scan_disable, but at the same time the HCI_LE_SCAN_RESTART
was just set, and you get race condition that would cause the scan to
be restarted instead of being disabled and run all the time.
The way I wrote that right now you can't get that race condition.

>
> That said, I like to get this working also with the regular discovery pro=
cedure. It is just that there every found device will trigger the restart, =
while in the service discovery it is only the ones we care about. So we sho=
uld expose an general mechanism here.


When I was initially implementing service scan, I was doing it inside
regular scan, and le_scan_restart was working fine there (later I just
extracted different opcode for the scan method). There's nothing
special now in regular, or service scan that would make
le_scan_restart not work.

>
>
> I do not have figured every single detail our here, but that is where I l=
ike to go with this.


queue_delayed_work

>
>
> Regards
>
> Marcel
>
