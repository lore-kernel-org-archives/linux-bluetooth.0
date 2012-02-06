Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328554926.2062.84.camel@aeonflux>
References: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20120206152113.GA12729@x220>
	<1328554926.2062.84.camel@aeonflux>
Date: Mon, 6 Feb 2012 21:36:06 +0200
Message-ID: <CAMXE1-rSmSVvYyRjLo2pZWLfFF+QWh-1pTz--+uNstLHR367aQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix device reset
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=20cf300e54151109a104b850c625
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf300e54151109a104b850c625
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

06.02.2012 21:04 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=
=B5=D0=BB=D1=8C "Marcel Holtmann" <marcel@holtmann.org>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>
> Hi Johan,
>
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > >
> > >
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/hci_core.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index e77cc79..3f30714 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> > >     skb_queue_purge(&hdev->cmd_q);
> > >     atomic_set(&hdev->cmd_cnt, 1);
> > >     if (!test_bit(HCI_RAW, &hdev->flags) &&
> > > -                           test_bit(HCI_QUIRK_NO_RESET,
&hdev->quirks)) {
> > > +                   !test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
> > >             set_bit(HCI_INIT, &hdev->flags);
> > >             __hci_request(hdev, hci_reset_req, 0,
> > >                                     msecs_to_jiffies(250));
> >
> > Nack. The NO_RESET quirk is supposed to prevent reset during the device
> > init sequence. The purpose of the test in hci_dev_do_close() is to let
> > the reset be done there instead.
>
> we might wanna rename this into HCI_QUIRK_RESET_ON_CLOSE. Otherwise
> people keep in getting confused.
>

Moreover without my patch my USB dongle gets stuck after reset.

Regards
Andrei

--20cf300e54151109a104b850c625
Content-Type: text/html; charset=KOI8-R
Content-Transfer-Encoding: quoted-printable

<p>Hi,</p>
<p>06.02.2012 21:04 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=D8 &quot;Marcel Holtm=
ann&quot; &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a=
>&gt; =CE=C1=D0=C9=D3=C1=CC:<br>
&gt;<br>
&gt; Hi Johan,<br>
&gt;<br>
&gt; &gt; &gt; From: Andrei Emeltchenko &lt;<a href=3D"mailto:andrei.emeltc=
henko@intel.com">andrei.emeltchenko@intel.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Andrei Emeltchenko &lt;<a href=3D"mailto:andr=
ei.emeltchenko@intel.com">andrei.emeltchenko@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; =9Anet/bluetooth/hci_core.c | =9A =9A2 +-<br>
&gt; &gt; &gt; =9A1 files changed, 1 insertions(+), 1 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_co=
re.c<br>
&gt; &gt; &gt; index e77cc79..3f30714 100644<br>
&gt; &gt; &gt; --- a/net/bluetooth/hci_core.c<br>
&gt; &gt; &gt; +++ b/net/bluetooth/hci_core.c<br>
&gt; &gt; &gt; @@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_d=
ev *hdev)<br>
&gt; &gt; &gt; =9A =9A skb_queue_purge(&amp;hdev-&gt;cmd_q);<br>
&gt; &gt; &gt; =9A =9A atomic_set(&amp;hdev-&gt;cmd_cnt, 1);<br>
&gt; &gt; &gt; =9A =9A if (!test_bit(HCI_RAW, &amp;hdev-&gt;flags) &amp;&am=
p;<br>
&gt; &gt; &gt; - =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A test_b=
it(HCI_QUIRK_NO_RESET, &amp;hdev-&gt;quirks)) {<br>
&gt; &gt; &gt; + =9A =9A =9A =9A =9A =9A =9A =9A =9A !test_bit(HCI_QUIRK_NO=
_RESET, &amp;hdev-&gt;quirks)) {<br>
&gt; &gt; &gt; =9A =9A =9A =9A =9A =9A set_bit(HCI_INIT, &amp;hdev-&gt;flag=
s);<br>
&gt; &gt; &gt; =9A =9A =9A =9A =9A =9A __hci_request(hdev, hci_reset_req, 0=
,<br>
&gt; &gt; &gt; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A msecs_to_jiffies(250));<br>
&gt; &gt;<br>
&gt; &gt; Nack. The NO_RESET quirk is supposed to prevent reset during the =
device<br>
&gt; &gt; init sequence. The purpose of the test in hci_dev_do_close() is t=
o let<br>
&gt; &gt; the reset be done there instead.<br>
&gt;<br>
&gt; we might wanna rename this into HCI_QUIRK_RESET_ON_CLOSE. Otherwise<br=
>
&gt; people keep in getting confused.<br>
&gt;</p>
<p>Moreover without my patch my USB dongle gets stuck after reset.<br></p>
<p>Regards<br>
Andrei</p>

--20cf300e54151109a104b850c625--
