Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4F352951
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813851; cv=none; b=szDBGqWM4CuxwxeLvoFvthUjAz/7of58grntFkrjVqX5enVSChI7/R/nit3ReBf8D9rpniGu+UIIwayCV9Pvi30EBU+p2aJB7V8zBAZhfPAsf6BCTsxW1hj2/TTcc22rvZiPB5WTrXoNg3gcqXO0sBoeu7dr9W6AD6QZYDi6syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813851; c=relaxed/simple;
	bh=4LBQMfpQBQl/f59kRuOYqzc+Wu3G0rk1c+yPqAzJbnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzEL95HbuSDzMqXNDh1SacGzFlFnwUCD1BYOnftHUjmiRu/5atl+UOoKTachooITK4Wh5WJx2/SLVhUlx/5fH7ovAw1Zx1P1jQv0qtu057QP6X0jwjvH63byclm3LwHizW3qpMO/j4chWfekQJ5OIJZ+Bfh6avrZOYZOonYcUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5E7F1F47A;
	Mon, 19 Jan 2026 09:10:41 +0000 (UTC)
Message-ID: <7a5b73b4c56d0bfb8742045a3f530cd3d2d25b53.camel@hadess.net>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
From: Bastien Nocera <hadess@hadess.net>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, kernel test robot
	 <lkp@intel.com>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>
Cc: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Date: Mon, 19 Jan 2026 10:10:41 +0100
In-Reply-To: <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260116125803.598552-3-hadess@hadess.net>
	 <202601170322.MZrwlt6M-lkp@intel.com>
	 <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieekjeffheefveelvdffudekudeikeffveduudetgeffgfekueeffeetueduveejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhlohhrvgdrkhgvpddvheegtdhhrgguvghsshdrnhgvthdptddurdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepgfehgfejhfduhfegjeetpdhmohguv
 gepshhmthhpohhuthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehnvggvrhgrjhdrshgrnhhjrgihkhgrlhgvsehngihprdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvh

On Mon, 2026-01-19 at 07:53 +0000, Neeraj Sanjay Kale wrote:
> Hi Bastien,
>=20
> Thank you for your patch.
>=20
> Just an FYI, the " #ifdef CONFIG_PM_SLEEP" was added on purpose to
> resolve such build warning reported by kernel test bot:
> https://lore.kernel.org/all/20240710123426.935122-1-neeraj.sanjaykale@nxp=
.com/

I didn't see those warnings locally. They should be fixed by using
__maybe_unused instead otherwise the "it extends the code coverage"
justification wouldn't really apply anymore.

Cheers

>=20
> Thanks,
> Neeraj
>=20
> > Hi Bastien,
> >=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on bluetooth/master] [also build test
> > WARNING on
> > linus/master v6.19-rc5] [cannot apply to bluetooth-next/master
> > next-
> > 20260116] [If your patch is applied to the wrong git tree, kindly
> > drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-/
> > scm.com%2Fdocs%2Fgit-format-
> > patch%23_base_tree_information&data=3D05%7C02%7Cneeraj.sanjaykale%40n
> > xp.com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92
> > cd99c5c301635%7C0%7C0%7C639041898935601715%7CUnknown%7CTWFp
> > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DW4jhk2S
> > VUr77jirvKdK%2FrKuKAVyXSbY9iO2pQ1%2BL7Fs%3D&reserved=3D0]
> >=20
> > url:
> > https://github/.
> > com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FBastien-Nocera%2FBluetooth-
> > btmtksdio-Simplify-dev_pm_ops-usage%2F20260116-
> > 210400&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a754
> > 0774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C639041898935632879%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> > kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUI
> > j
> > oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dl2nEr61x%2F00NrtEqmvX2qhJ%2F0d
> > %2Fc6T%2BI6e5YRiz1TAM%3D&reserved=3D0
> > base:
> > https://git.kern/
> > el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbluetooth%2Fbluetooth.g
> > i
> > t&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> > da08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > 9041898935651605%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> > dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> > 3
> > D%3D%7C0%7C%7C%7C&sdata=3D%2BKZxHj6EXqJXKC8%2FsiYrPOJczts%2BMEX
> > ycXixKcxUcf8%3D&reserved=3D0 master
> > patch link:
> > https://lore.ke/
> > rnel.org%2Fr%2F20260116125803.598552-3-
> > hadess%2540hadess.net&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%
> > 7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c3
> > 01635%7C0%7C0%7C639041898935668808%7CUnknown%7CTWFpbGZsb3d8
> > eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> > oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Da3gomBec5GENv5B
> > RsBv%2Butzd11I3QunXE2yAaDg5f4Q%3D&reserved=3D0
> > patch subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded
> > CONFIG_PM ifdef
> > config: x86_64-randconfig-002-20260116
> > (https://downl/
> > oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > lkp%40intel.com%2Fconfig&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> > %7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c
> > 301635%7C0%7C0%7C639041898935685518%7CUnknown%7CTWFpbGZsb3d
> > 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> > joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhR230cwqc4FucDn
> > 9TPmv79VLdAd8kHHwc2Q8SdPtHtk%3D&reserved=3D0)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0 reproduce (this is a W=3D1
> > build):
> > (https://downl/
> > oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > lkp%40intel.com%2Freproduce&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.
> > com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd9
> > 9c5c301635%7C0%7C0%7C639041898935702245%7CUnknown%7CTWFpbGZ
> > sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> > IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdsZA9O8KQy
> > QZJK2Fn%2FYtexA8zdrw%2FCcpwnEb7AwhiqU%3D&reserved=3D0)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore/
> > > .kernel.org%2Foe-kbuild-all%2F202601170322.MZrwlt6M-
> > lkp%40intel.com%2F
> > >=20
> > &data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> > da08de
> > >=20
> > 5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63904189
> > 89357202
> > >=20
> > 33%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> > uMDAwMCI
> > >=20
> > sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> > ata=3D2
> > > s046Nm4SrgCfY%2BqPyoYr8tf5xqoBw%2BqDiJ0YQ%2BiAt8%3D&reserved=3D0
> >=20
> > All warnings (new ones prefixed by >>):
> >=20
> > > > drivers/bluetooth/btnxpuart.c:1964:12: warning:
> > > > 'nxp_serdev_resume'
> > > > defined but not used [-Wunused-function]
> > =C2=A0=C2=A0=C2=A0 1964 | static int nxp_serdev_resume(struct device *d=
ev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> > > > drivers/bluetooth/btnxpuart.c:1950:12: warning:
> > > > 'nxp_serdev_suspend'
> > > > defined but not used [-Wunused-function]
> > =C2=A0=C2=A0=C2=A0 1950 | static int nxp_serdev_suspend(struct device *=
dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> >=20
> >=20
> > vim +/nxp_serdev_resume +1964 drivers/bluetooth/btnxpuart.c
> >=20
> > 689ca16e5232784 Neeraj Sanjay Kale 2023-03-16=C2=A0 1949
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1950=C2=A0 static int
> > nxp_serdev_suspend(struct device *dev)
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1951=C2=A0 {
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1952=C2=A0=C2=A0=C2=
=A0=C2=A0 struct
> > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1953=C2=A0=C2=A0=C2=
=A0=C2=A0 struct
> > ps_data
> > *psdata =3D &nxpdev->psdata;
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1954
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1955=C2=A0=C2=A0=C2=
=A0=C2=A0
> > ps_control(psdata-
> > > hdev, PS_STATE_SLEEP);
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1956
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1957=C2=A0=C2=A0=C2=
=A0=C2=A0 if (psdata-
> > > wakeup_source) {
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1958
> > enable_irq_wake(psdata->irq_handler);
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1959
> > enable_irq(psdata->irq_handler);
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1960=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1961=C2=A0=C2=A0=C2=
=A0=C2=A0 return 0;
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1962=C2=A0 }
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1963
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1964=C2=A0 static int
> > nxp_serdev_resume(struct device *dev)
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1965=C2=A0 {
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1966=C2=A0=C2=A0=C2=
=A0=C2=A0 struct
> > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1967=C2=A0=C2=A0=C2=
=A0=C2=A0 struct
> > ps_data
> > *psdata =3D &nxpdev->psdata;
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1968
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1969=C2=A0=C2=A0=C2=
=A0=C2=A0 if (psdata-
> > > wakeup_source) {
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1970
> > disable_irq(psdata->irq_handler);
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1971
> > disable_irq_wake(psdata->irq_handler);
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1972=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1973
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1974=C2=A0=C2=A0=C2=
=A0=C2=A0
> > ps_control(psdata-
> > > hdev, PS_STATE_AWAKE);
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1975=C2=A0=C2=A0=C2=
=A0=C2=A0 return 0;
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1976=C2=A0 }
> > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1977
> >=20
> > --
> > 0-DAY CI Kernel Test Service
> > https://github/.
> > com%2Fintel%2Flkp-
> > tests%2Fwiki&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f321914
> > 6a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> > %7C0%7C639041898935740752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> > U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> > sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIqE%2B%2BS2ZXcZb5PFvsvemp
> > dQffNOiktBLNpxdDx5JJJg%3D&reserved=3D0
>=20
