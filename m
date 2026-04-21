Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807337A49C
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756798; cv=none; b=KW6F/4EKpqDAtQQjKu2+pBwhb/IAsYQoBERUh98O5006PRnnXjQegrfnOBraG5OlRwxe+7hF77DIE99Qy3dAp19n7UNMFDgJoNQudgsoIO/wu/PJgIlzE0Hrlm6XskufZ7dF8hvf50cAi5Ez/Bvyll3AxtIRoHiYdxfzq3MaAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756798; c=relaxed/simple;
	bh=Pkx5Ks341xpMMNT9rTWoGstO0+9jKfn3n7TXoWiIw10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fO4HZ8SyLQ10WrorajIm7yTHjzJq9jqgEML+EWv1SN/DnP/DpaFpc630Fgvq4F9le/DbPN7bDHVMyYKYA0ZwDQvKc010GuNfxmL/XxgbTdZ9Qux4QqwJa2OpQayzQ5HeKhU8LIA6Xhi9e5/M9cORSYWL5+3HPizUZXAf9uXNJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAD313ED43;
	Tue, 21 Apr 2026 07:33:07 +0000 (UTC)
Message-ID: <f57e142712d4bd5a02d99a278e6f2d5620c1ded9.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for
 combo chips
From: Bastien Nocera <hadess@hadess.net>
To: =?UTF-8?Q?=C8=98tefan?= Condorache <condorachest@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Apr 2026 09:33:07 +0200
In-Reply-To: <CAGfCjSajE4hBroEUXa=LNw1Z=52b6oT7DsFBm_X_LVphpLoLBA@mail.gmail.com>
References: <20260419072433.55976-1-condorachest@gmail.com>
	 <8961a9ba3e4a48eaa33060114366573439bbf73f.camel@iki.fi>
	 <c4593a49ef6ed7151eceebfd22d602a0d018e9f5.camel@hadess.net>
	 <CAGfCjSajE4hBroEUXa=LNw1Z=52b6oT7DsFBm_X_LVphpLoLBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTEoog9EmaDpCj5JZVNhP+2lfk3XsnP38BDwZsm1X6+txnxIg8Wg1/Rk01gY5ApOJLV921kopj6tJsvXksLNxHP9nHWmmPoO0r/SjXVyjA+g6U0ApYXqy9+zfcG0RElmckmbWAfJ4dPtQnlCNunqByuyDdLgY/j8LeIIGC6026KPgi4+5Xi+NbIKKXVAJOnqJKE1nCOHzxWjWe0xll6msK+sEZG3ewkBptu5SjW3dyrXq5mQEKntpsqsbF51THFYKv8efe2p1anZpg6sjAi40vGraBxPg6SC1/Nemzh8tuXB2Hy20zAExUfUWzjPS23JDcEZZMsgN+e/F22NyVi3YiUsLe/u2KI+7FgfwhKVMLazLEFd9OvxMSAFNpQYk0Dt9VNr/xFAwfAuzhYJivnWhDxa0lJ6oDvfU1z7rhu12zo8OIKmen6WqCYtKJwni80J3tposAcjKZBbkgChoixt3Grkr4GwXrbMMHXo2x+44SLudgyNnrLmiJ7GepeQZaIsMVeisWHFSA8iirJUSHZaCSFKBNhuL0xdZoNlvjk5I+TD4hyZX812M87ZIfHq1974DcOK/F0R8n0gw5f3+0/5WQ8G57IAWhBT2VHWIhThHIzwPT+4iABvp1bR+tmpKZcb2nrW5IgfBR9l/eMTfUjqcO2611atEJs6sVF/THfBPTb8EQ
X-GND-State: clean

Hello =C8=98tefan,

The mailing-list needs to be put on CC. FWIW, this LLM-generated reply
that doesn't verify anything and takes me at my word really isn't
useful.

Cheers

On Mon, 2026-04-20 at 19:07 +0300, =C8=98tefan Condorache wrote:
> Hi Bastien,=C2=A0
>=20
> Thank you for the detailed feedback.=C2=A0
> =C2=A0Regarding your questions:=C2=A0
> You are correct that vendor Realtek drivers implement BT/Wi-Fi
> coexistence.=C2=A0
> The upstream driver lacks this. This quirk is intended as a stopgap
> until proper=C2=A0
> coexistence support is implemented upstream.=C2=A0
>=20
> The quirk should be removed once the upstream driver gains
> coexistence support=C2=A0
> equivalent to the vendor driver. Testing was done by streaming audio
> over Bluetooth=C2=A0
> while running continuous Wi-Fi traffic (iperf3) and observing audio
> dropouts.=C2=A0
> With the quirk enabled the dropouts stop. I acknowledge this is not
> an automated reproducible test, which is a weakness.
>=20
> On Mon, Apr 20, 2026 at 12:08=E2=80=AFPM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> > On Sun, 2026-04-19 at 13:35 +0300, Pauli Virtanen wrote:
> > > Hi,
> > >=20
> > > su, 2026-04-19 kello 10:24 +0300, StefanCondorache kirjoitti:
> > > > Realtek combo chips share a single antenna between Wi-Fi and
> > > > Bluetooth.
> > > > Background LE passive scanning while an active connection
> > > > exists
> > > > causes
> > > > antenna multiplexing conflicts via Packet Traffic Arbitration
> > > > (PTA),
> > > > resulting in audio stuttering and Wi-Fi packet loss.
> > > >=20
> > > > Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive
> > > > scanning
> > > > in
> > > > hci_update_passive_scan_sync() when active connections are
> > > > present.
> > > > Set this quirk for all Realtek devices in btrtl_set_quirks().
> > >=20
> > > Some general questions on this, which are not immediately
> > > apparent
> > > from
> > > the commit message:
> > >=20
> > > How is it know which Realtek models have this bug?
> > >=20
> > > Which ones were tested?
> > >=20
> > > Is it better to set the quirk for all Realtek devices than do it
> > > per
> > > USB id / chipset for each known bad device?
> >=20
> > I worked on the rtl8723bs Wi-Fi driver in a previous life (so much
> > so
> > that I can spell out the model number on top of my head), and I
> > remember it having code for BT/Wi-Fi coexistence.
> >=20
> > Is this only a problem with the lack of BT/Wi-Fi coexistence
> > support in
> > the upstream Linux drivers (eg. not in the Realtek vendor drivers)
> >=20
> > How do you actually test this in a reliable and reproducible way?
> > How
> > will we know to remove this quirk?
> >=20
> > > > Also add device ID 0x0bda:0xc829 to the btusb Realtek device
> > > > table.
> > >=20
> > > Patches adding USB device ids usually have USB info from
> > > /sys/kernel/debug/usb/devices in the commit message, see other
> > > patches
> > > add these. Probably should be separate patch?
> > >=20
> > > > Signed-off-by: StefanCondorache <condorachest@gmail.com>
> > > > ---
> > > > =C2=A0drivers/bluetooth/btrtl.c=C2=A0=C2=A0 |=C2=A0 6 ++++++
> > > > =C2=A0drivers/bluetooth/btusb.c=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > =C2=A0include/net/bluetooth/hci.h | 11 +++++++++++
> > > > =C2=A0net/bluetooth/hci_sync.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++++
> > > > =C2=A04 files changed, 26 insertions(+)
> > > >=20
> > > > diff --git a/drivers/bluetooth/btrtl.c
> > > > b/drivers/bluetooth/btrtl.c
> > > > index 62f9d4df3a4f..00dfba656970 100644
> > > > --- a/drivers/bluetooth/btrtl.c
> > > > +++ b/drivers/bluetooth/btrtl.c
> > > > @@ -1299,6 +1299,12 @@
> > > > EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > > > =C2=A0
> > > > =C2=A0void btrtl_set_quirks(struct hci_dev *hdev, struct
> > > > btrtl_device_info *btrtl_dev)
> > > > =C2=A0{
> > > > +=C2=A0 =C2=A0/* Realtek combo chips share the antenna between Wi-F=
i and
> > > > +=C2=A0 =C2=A0 * Bluetooth. Suppress passive scanning while connect=
ed to
> > > > +=C2=A0 =C2=A0 * prevent coexistence issues.
> > > > +=C2=A0 =C2=A0 */
> > > > +=C2=A0 =C2=A0hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED=
);
> > >=20
> > > This sets the quirk for all Realtek chips.
> > >=20
> > > Realtek chips are also in stuff like Bluetooth USB dongles that
> > > are
> > > not
> > > combo wifi ones. Can they be identified?
> > >=20
> > > > +
> > > > =C2=A0=C2=A0 =C2=A0/* Enable controller to do both LE scan and BR/E=
DR inquiry
> > > > =C2=A0=C2=A0 =C2=A0 * simultaneously.
> > > > =C2=A0=C2=A0 =C2=A0 */
> > > > diff --git a/drivers/bluetooth/btusb.c
> > > > b/drivers/bluetooth/btusb.c
> > > > index 5f57953393be..87972f5fc567 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -516,6 +516,8 @@ static const struct usb_device_id
> > > > quirks_table[] =3D {
> > > > =C2=A0=C2=A0 =C2=A0/* Realtek 8822CU Bluetooth devices */
> > > > =C2=A0=C2=A0 =C2=A0{ USB_DEVICE(0x13d3, 0x3549), .driver_info =3D B=
TUSB_REALTEK
> > > > |
> > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > BTUSB_WIDEBAND_SPEECH },
> > > > +=C2=A0 =C2=A0{ USB_DEVICE(0x0bda, 0xc829), .driver_info =3D BTUSB_=
REALTEK
> > > > |
> > > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
> > > > BTUSB_WIDEBAND_SPEECH },
> > > > =C2=A0
> > > > =C2=A0=C2=A0 =C2=A0/* Realtek 8851BE Bluetooth devices */
> > > > =C2=A0=C2=A0 =C2=A0{ USB_DEVICE(0x0bda, 0xb850), .driver_info =3D B=
TUSB_REALTEK
> > > > },
> > > > diff --git a/include/net/bluetooth/hci.h
> > > > b/include/net/bluetooth/hci.h
> > > > index 572b1c620c5d..8466dc52aeca 100644
> > > > --- a/include/net/bluetooth/hci.h
> > > > +++ b/include/net/bluetooth/hci.h
> > > > @@ -378,6 +378,17 @@ enum {
> > > > =C2=A0=C2=A0 =C2=A0 */
> > > > =C2=A0=C2=A0 =C2=A0HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > > > =C2=A0
> > > > +=C2=A0 =C2=A0/* When this quirk is set, the controller suppresses
> > > > passive LE
> > > > +=C2=A0 =C2=A0 * background scanning while an active connection exi=
sts.
> > > > +=C2=A0 =C2=A0 * This is required for combo chips with shared Wi-
> > > > Fi/Bluetooth
> > > > +=C2=A0 =C2=A0 * antennas to prevent coexistence issues causing aud=
io
> > > > drops
> > > > +=C2=A0 =C2=A0 * and Wi-Fi packet loss.
> > > > +=C2=A0 =C2=A0 *
> > > > +=C2=A0 =C2=A0 * This quirk can be set before hci_register_dev is c=
alled
> > > > or
> > > > +=C2=A0 =C2=A0 * during the hdev->setup vendor callback.
> > > > +=C2=A0 =C2=A0 */
> > > > +=C2=A0 =C2=A0HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
> > > > +
> > > > =C2=A0=C2=A0 =C2=A0__HCI_NUM_QUIRKS,
> > > > =C2=A0};
> > > > =C2=A0
> > > > diff --git a/net/bluetooth/hci_sync.c
> > > > b/net/bluetooth/hci_sync.c
> > > > index fd3aacdea512..5e30e725efa2 100644
> > > > --- a/net/bluetooth/hci_sync.c
> > > > +++ b/net/bluetooth/hci_sync.c
> > > > @@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct
> > > > hci_dev *hdev)
> > > > =C2=A0=C2=A0 =C2=A0if (hdev->discovery.state !=3D DISCOVERY_STOPPED=
)
> > > > =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > > > =C2=A0
> > > > +=C2=A0 =C2=A0/* If the controller requires no scanning while conne=
cted,
> > > > +=C2=A0 =C2=A0 * suppress passive scanning when an active connectio=
n
> > > > exists.
> > > > +=C2=A0 =C2=A0 */
> > > > +=C2=A0 =C2=A0if (hci_test_quirk(hdev,
> > > > HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
> > > > +=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 !list_empty(&hdev->conn_hash.list)=
)
> > > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > > > +
> > >=20
> > > Does this break initiating connections via hci_connect_le_scan()
> > > if
> > > another connection is active?
> > >=20
> > > Is it possible to make more than one LE connection
> > > simultaneously?
> > >=20
> > > > =C2=A0=C2=A0 =C2=A0/* Reset RSSI and UUID filters when starting bac=
kground
> > > > scanning
> > > > =C2=A0=C2=A0 =C2=A0 * since these filters are meant for service dis=
covery
> > > > only.
> > > > =C2=A0=C2=A0 =C2=A0 *
