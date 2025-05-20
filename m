Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149ED2676F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736538; cv=none; b=H/TO6g3Lu5PtCIrfw++LthovO5Wdl/3rIb8DvbLlaJ4tJvx5CActMc/+7izx++ekMpUv3mZ4uXqnoGhaJn8NDi2Ud2XcKW4zyOiR4nG/CoFHMytUBqO72nO4o9ehWZOc6bSqDrL8RYblKP8eePqn1bpubPoOK63NMnWmixZ07dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736538; c=relaxed/simple;
	bh=PqZqh5F9ykycOgUiC938WZV4eQjN1x0YidwCuC/yAfI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIfszsS1Qd/+ntWip0zsMnNvBOMuxWqy69rCHais/8MsBn2Vx5O/32YSVxevi6m0xFlRbLPBsRIqi7OOZg+z60BdZ+qXViFVLEKtaZuvDOHZgO3gZJGrWnSxDptwbMun4Q7s5mP8HOjbH+ssu0Aiy790c7Ja+UI1DNm1eS+vl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF194439A8;
	Tue, 20 May 2025 10:22:06 +0000 (UTC)
Message-ID: <a449a563d74a2df27dd6f0c95365ea4e97053b9e.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/3] doc/device: Add Disconnected signal
From: Bastien Nocera <hadess@hadess.net>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
 Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 May 2025 12:22:06 +0200
In-Reply-To: <6acf1b43-77f6-4484-8af6-5fe492e6ec6e@collabora.com>
References: <20250519161412.107904-1-frederic.danis@collabora.com>
	 <20250519161412.107904-3-frederic.danis@collabora.com>
	 <CABBYNZL2LBBSMvBDONLf6H8-re26YHKBxsnQwNbX8kNuiq8m_Q@mail.gmail.com>
	 <d4c4cb4cc03b23f21ac9e9c5041937ccfc3f81f5.camel@hadess.net>
	 <6acf1b43-77f6-4484-8af6-5fe492e6ec6e@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdegtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehfrhgvuggvrhhitgdruggrnhhishestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhot
 hhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

On Tue, 2025-05-20 at 11:32 +0200, Fr=C3=A9d=C3=A9ric Danis wrote:
> Hi Bastien,
>=20
> On 19/05/2025 21:22, Bastien Nocera wrote:
> > On Mon, 2025-05-19 at 12:44 -0400, Luiz Augusto von Dentz wrote:
> > > Hi Fr=C3=A9d=C3=A9ric,
> > >=20
> > > On Mon, May 19, 2025 at 12:18=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
> > > <frederic.danis@collabora.com> wrote:
> > > > ---
> > > > =C2=A0=C2=A0doc/org.bluez.Device.rst | 17 +++++++++++++++++
> > > > =C2=A0=C2=A01 file changed, 17 insertions(+)
> > > >=20
> > > > diff --git a/doc/org.bluez.Device.rst
> > > > b/doc/org.bluez.Device.rst
> > > > index 80501eddd..6229f95ad 100644
> > > > --- a/doc/org.bluez.Device.rst
> > > > +++ b/doc/org.bluez.Device.rst
> > > > @@ -155,6 +155,23 @@ array{array{byte}} GetServiceRecords()
> > > > [experimental]
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :org.bluez.Error.N=
otConnected:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :org.bluez.Error.D=
oesNotExist:
> > > >=20
> > > > +Signals
> > > > +-------
> > > > +
> > > > +void Disconnected(string reason)
> > > > +````````````````````````````````
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This signal is launched when =
a device is disconnected
> > > > with
> > > > the reason of
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the disconnection.
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Possible reasons:
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-unknown:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-timeout:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-local-host:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-remote:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :disconnection-local-suspend:
> > > Perhaps it would be better to use to the actual HCI code instead
> > > of
> > > converting it to string, since I suspect application using this
> > > signal
> > > may want to recover the actual error to do some sort of
> > > reconnecting
> > > policy, etc, or having them both in case the client just wants to
> > > print it.
> > If there are applications using those signals (I'm guessing,
> > Bluetooth
> > settings apps), whatever the format of the error, could we have an
> > expected behaviour associated with individual error types?
>=20
> This could be used by client apps like Bluetooth setting to try to
> reconnect to the device in case of timeout or unknown disconnection,
> or to try to connect to another device depending on internal policy.

I meant having that information in the docs :)

Cheers
