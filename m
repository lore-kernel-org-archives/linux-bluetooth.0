Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A7366DD6
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929465; cv=none; b=ADlqd/BF5DI0+3CLT2ksB/kP0RGHPSYvbPG7t7si/skIBr5Drxee77Be2LZ4UfdZ8xMDU9MT0Vxp65hURYlwZ4KY6fH4n2gkXGqeqTfoa9UEkJoYBSfiP+SX8L1v7DKoGegA5BMRbHzW+0mG8KrW9kMIrTyqqnMsDs3NKOVik1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929465; c=relaxed/simple;
	bh=YY2+UGBboDQmUaxHtzliXuVbPQK29i7Dvofqz+vVF34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQybCceYz88Zgxs3Yag730Kjj3CTwINqehfga2btjMzQwwxwF/jj8QXKylZX5p9inYjTJ2Aoy/4kyxfzHTnzPsmhgkHJXB0nsprp0ZJS6wzl76/co+H35uXu9ebUO7EFzunCbJVhY4DzI7O0B9OWgMwKujdfkURPrtEfx6STjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D81E4435C;
	Tue, 20 Jan 2026 17:17:33 +0000 (UTC)
Message-ID: <c4be5c93c1d83ab8fa3ff0dafe8efc3a827e0ebb.camel@hadess.net>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, kernel test robot
	 <lkp@intel.com>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>, "oe-kbuild-all@lists.linux.dev"
	 <oe-kbuild-all@lists.linux.dev>
Date: Tue, 20 Jan 2026 18:17:32 +0100
In-Reply-To: <CABBYNZL6hAxsnBt=HStvhnZmoTfagzGuJ0sGeqiqhXdpm0DZOA@mail.gmail.com>
References: <20260116125803.598552-3-hadess@hadess.net>
	 <202601170322.MZrwlt6M-lkp@intel.com>
	 <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
	 <7a5b73b4c56d0bfb8742045a3f530cd3d2d25b53.camel@hadess.net>
	 <CABBYNZL6hAxsnBt=HStvhnZmoTfagzGuJ0sGeqiqhXdpm0DZOA@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieekjeffheefveelvdffudekudeikeffveduudetgeffgfekueeffeetueduveejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhlohhrvgdrkhgvpddvheegtdhhrgguvghsshdrnhgvthdptddurdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepjeffkedugfeggeefheevpdhmohguv
 gepshhmthhpohhuthdpnhgspghrtghpthhtohephedprhgtphhtthhopehluhhiiiguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvvghrrghjrdhsrghnjhgrhihkrghlvgesnhigphdrtghomhdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-State: clean
X-GND-Score: -100

On Tue, 2026-01-20 at 11:42 -0500, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Jan 19, 2026 at 4:13=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > On Mon, 2026-01-19 at 07:53 +0000, Neeraj Sanjay Kale wrote:
> > > Hi Bastien,
> > >=20
> > > Thank you for your patch.
> > >=20
> > > Just an FYI, the " #ifdef CONFIG_PM_SLEEP" was added on purpose
> > > to
> > > resolve such build warning reported by kernel test bot:
> > > https://lore.kernel.org/all/20240710123426.935122-1-neeraj.sanjaykale=
@nxp.com/
> >=20
> > I didn't see those warnings locally. They should be fixed by using
> > __maybe_unused instead otherwise the "it extends the code coverage"
> > justification wouldn't really apply anymore.
>=20
> Yes, I think we should mark the functions that are conditional with
> __maybe_unused, actually this might be the case with
> btusb_resume/btusb_suspend as well, right?

I believe that's what I've done that in v3. Let me know if there are
any problems with that version still.

Cheers

>=20
> >=20
> > Cheers
> >=20
> > >=20
> > > Thanks,
> > > Neeraj
> > >=20
> > > > Hi Bastien,
> > > >=20
> > > > kernel test robot noticed the following build warnings:
> > > >=20
> > > > [auto build test WARNING on bluetooth/master] [also build test
> > > > WARNING on
> > > > linus/master v6.19-rc5] [cannot apply to bluetooth-next/master
> > > > next-
> > > > 20260116] [If your patch is applied to the wrong git tree,
> > > > kindly
> > > > drop us a
> > > > note.
> > > > And when submitting patch, we suggest to use '--base' as
> > > > documented
> > > > in
> > > > https://git-/
> > > > scm.com%2Fdocs%2Fgit-format-
> > > > patch%23_base_tree_information&data=3D05%7C02%7Cneeraj.sanjaykale
> > > > %40n
> > > > xp.com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92
> > > > cd99c5c301635%7C0%7C0%7C639041898935601715%7CUnknown%7CTWFp
> > > > bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> > > > z
> > > > MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DW4jhk2S
> > > > VUr77jirvKdK%2FrKuKAVyXSbY9iO2pQ1%2BL7Fs%3D&reserved=3D0]
> > > >=20
> > > > url:
> > > > https://github/.
> > > > com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FBastien-
> > > > Nocera%2FBluetooth-
> > > > btmtksdio-Simplify-dev_pm_ops-usage%2F20260116-
> > > > 210400&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7
> > > > 54
> > > > 0774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > > %7C639041898935632879%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> > > > kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsI
> > > > ldUI
> > > > j
> > > > oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dl2nEr61x%2F00NrtEqmvX2qhJ%2F0d
> > > > %2Fc6T%2BI6e5YRiz1TAM%3D&reserved=3D0
> > > > base:
> > > > https://git.kern/
> > > > el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbluetooth%2Fbluetoo
> > > > th.g
> > > > i
> > > > t&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a754077
> > > > 4e
> > > > da08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> > > > 9041898935651605%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> > > > dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo
> > > > yfQ%
> > > > 3
> > > > D%3D%7C0%7C%7C%7C&sdata=3D%2BKZxHj6EXqJXKC8%2FsiYrPOJczts%2BMEX
> > > > ycXixKcxUcf8%3D&reserved=3D0 master
> > > > patch link:
> > > > https://lore.ke/
> > > > rnel.org%2Fr%2F20260116125803.598552-3-
> > > > hadess%2540hadess.net&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.co
> > > > m%
> > > > 7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c
> > > > 3
> > > > 01635%7C0%7C0%7C639041898935668808%7CUnknown%7CTWFpbGZsb3d8
> > > > eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> > > > OIj
> > > > oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Da3gomBec5GENv5B
> > > > RsBv%2Butzd11I3QunXE2yAaDg5f4Q%3D&reserved=3D0
> > > > patch subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove
> > > > unneeded
> > > > CONFIG_PM ifdef
> > > > config: x86_64-randconfig-002-20260116
> > > > (https://downl/
> > > > oad.01.org%2F0day-
> > > > ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > > > lkp%40intel.com%2Fconfig&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp
> > > > .com
> > > > %7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5
> > > > c
> > > > 301635%7C0%7C0%7C639041898935685518%7CUnknown%7CTWFpbGZsb3d
> > > > 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk
> > > > FOI
> > > > joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhR230cwqc4FucDn
> > > > 9TPmv79VLdAd8kHHwc2Q8SdPtHtk%3D&reserved=3D0)
> > > > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0 reproduce (this is a
> > > > W=3D1
> > > > build):
> > > > (https://downl/
> > > > oad.01.org%2F0day-
> > > > ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> > > > lkp%40intel.com%2Freproduce&data=3D05%7C02%7Cneeraj.sanjaykale%40
> > > > nxp.
> > > > com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd9
> > > > 9c5c301635%7C0%7C0%7C639041898935702245%7CUnknown%7CTWFpbGZ
> > > > sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi
> > > > Is
> > > > IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdsZA9O8KQy
> > > > QZJK2Fn%2FYtexA8zdrw%2FCcpwnEb7AwhiqU%3D&reserved=3D0)
> > > >=20
> > > > If you fix the issue in a separate patch/commit (i.e. not just
> > > > a
> > > > new version of
> > > > the same patch/commit), kindly add following tags
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes:
> > > > > https://lore/
> > > > > .kernel.org%2Foe-kbuild-all%2F202601170322.MZrwlt6M-
> > > > lkp%40intel.com%2F
> > > > >=20
> > > > &data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774
> > > > e
> > > > da08de
> > > > >=20
> > > > 5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63904189
> > > > 89357202
> > > > >=20
> > > > 33%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> > > > uMDAwMCI
> > > > >=20
> > > > sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&
> > > > sd
> > > > ata=3D2
> > > > > s046Nm4SrgCfY%2BqPyoYr8tf5xqoBw%2BqDiJ0YQ%2BiAt8%3D&reserved=3D
> > > > > 0
> > > >=20
> > > > All warnings (new ones prefixed by >>):
> > > >=20
> > > > > > drivers/bluetooth/btnxpuart.c:1964:12: warning:
> > > > > > 'nxp_serdev_resume'
> > > > > > defined but not used [-Wunused-function]
> > > > =C2=A0=C2=A0=C2=A0 1964 | static int nxp_serdev_resume(struct devic=
e *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> > > > > > drivers/bluetooth/btnxpuart.c:1950:12: warning:
> > > > > > 'nxp_serdev_suspend'
> > > > > > defined but not used [-Wunused-function]
> > > > =C2=A0=C2=A0=C2=A0 1950 | static int nxp_serdev_suspend(struct devi=
ce *dev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> > > >=20
> > > >=20
> > > > vim +/nxp_serdev_resume +1964 drivers/bluetooth/btnxpuart.c
> > > >=20
> > > > 689ca16e5232784 Neeraj Sanjay Kale 2023-03-16=C2=A0 1949
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1950=C2=A0 static in=
t
> > > > nxp_serdev_suspend(struct device *dev)
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1951=C2=A0 {
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1952=C2=A0=C2=
=A0=C2=A0=C2=A0 struct
> > > > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1953=C2=A0=C2=
=A0=C2=A0=C2=A0 struct
> > > > ps_data
> > > > *psdata =3D &nxpdev->psdata;
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1954
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1955
> > > > ps_control(psdata-
> > > > > hdev, PS_STATE_SLEEP);
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1956
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1957=C2=A0=C2=
=A0=C2=A0=C2=A0 if
> > > > (psdata-
> > > > > wakeup_source) {
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1958
> > > > enable_irq_wake(psdata->irq_handler);
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1959
> > > > enable_irq(psdata->irq_handler);
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1960=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1961=C2=A0=C2=
=A0=C2=A0=C2=A0 return
> > > > 0;
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1962=C2=A0 }
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1963
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1964=C2=A0 static in=
t
> > > > nxp_serdev_resume(struct device *dev)
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1965=C2=A0 {
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1966=C2=A0=C2=
=A0=C2=A0=C2=A0 struct
> > > > btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1967=C2=A0=C2=
=A0=C2=A0=C2=A0 struct
> > > > ps_data
> > > > *psdata =3D &nxpdev->psdata;
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1968
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1969=C2=A0=C2=
=A0=C2=A0=C2=A0 if
> > > > (psdata-
> > > > > wakeup_source) {
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1970
> > > > disable_irq(psdata->irq_handler);
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1971
> > > > disable_irq_wake(psdata->irq_handler);
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1972=C2=A0=C2=
=A0=C2=A0=C2=A0 }
> > > > c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14=C2=A0 1973
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1974
> > > > ps_control(psdata-
> > > > > hdev, PS_STATE_AWAKE);
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1975=C2=A0=C2=
=A0=C2=A0=C2=A0 return
> > > > 0;
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1976=C2=A0 }
> > > > 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05=C2=A0 1977
> > > >=20
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://github/.
> > > > com%2Fintel%2Flkp-
> > > > tests%2Fwiki&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f321
> > > > 914
> > > > 6a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> > > > %7C0%7C639041898935740752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> > > > U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
> > > > bCI
> > > > sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIqE%2B%2BS2ZXcZb5PFvsvemp
> > > > dQffNOiktBLNpxdDx5JJJg%3D&reserved=3D0
> > >=20
> >=20
>=20
