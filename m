Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB93EFD02
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945129; cv=none; b=gi0A/+8p+VQ73EeKipOVGY+wsu3q2SRWneQLR80SXkjJbK7RaGL5Y24wrSltvJ6bpRq5em1alzsSnqWSMpJ9ghhbcOYvelC+qhUw5xvzxsGTCJEF5NYZwZEo6CBsIDQn+jdHyrf9Thqy9jwWIlG/Ms4/CU48mMcIhwAYl1fzSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945129; c=relaxed/simple;
	bh=VVuZPbICVIH8RHKuItopCF3VeQZ+lOfmZNEvc9PuhrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfntAi0V7LbCT8K9zjtDtNiwWtaW0iauVwKjKkHH8MI7ngj1lzyBSsXca0I06TLInw2lAG5n9vO9leuCSHHw97Iw82xrMkH73Wm9mStT0u7sh6+AcFaPob0TSQm2UVbWcNo+qTzKPBGCoe35l3T1+sJNZP3o5OIXcp+Pyoaq8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A37AA43EED;
	Tue, 20 Jan 2026 21:38:38 +0000 (UTC)
Message-ID: <5498532ab2e09b4e0d6ccea09f0856b3df615331.camel@hadess.net>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, kernel test robot
	 <lkp@intel.com>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>, "oe-kbuild-all@lists.linux.dev"
	 <oe-kbuild-all@lists.linux.dev>
Date: Tue, 20 Jan 2026 22:38:38 +0100
In-Reply-To: <CABBYNZKP3ahsqi1XVPmD24RWkXnBbOAZ9NJpo3yg-6xBY22N4A@mail.gmail.com>
References: <20260116125803.598552-3-hadess@hadess.net>
	 <202601170322.MZrwlt6M-lkp@intel.com>
	 <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
	 <7a5b73b4c56d0bfb8742045a3f530cd3d2d25b53.camel@hadess.net>
	 <CABBYNZL6hAxsnBt=HStvhnZmoTfagzGuJ0sGeqiqhXdpm0DZOA@mail.gmail.com>
	 <c4be5c93c1d83ab8fa3ff0dafe8efc3a827e0ebb.camel@hadess.net>
	 <CABBYNZKP3ahsqi1XVPmD24RWkXnBbOAZ9NJpo3yg-6xBY22N4A@mail.gmail.com>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffeiueduvedutdffieehudetlefggfefgeeufeehudeujefhtdduvdekhfdvkefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeetfeejteetgeefgffgffdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtt
 hhopehnvggvrhgrjhdrshgrnhhjrgihkhgrlhgvsehngihprdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvh
X-GND-State: clean

On Tue, 2026-01-20 at 13:05 -0500, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, Jan 20, 2026 at 12:17=E2=80=AFPM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > On Tue, 2026-01-20 at 11:42 -0500, Luiz Augusto von Dentz wrote:
> > > Hi Bastien,
> > >=20
> > > On Mon, Jan 19, 2026 at 4:13=E2=80=AFAM Bastien Nocera
> > > <hadess@hadess.net>
> > > wrote:
> > > >=20
> > > > On Mon, 2026-01-19 at 07:53 +0000, Neeraj Sanjay Kale wrote:
> > > > > Hi Bastien,
> > > > >=20
> > > > > Thank you for your patch.
> > > > >=20
> > > > > Just an FYI, the " #ifdef CONFIG_PM_SLEEP" was added on
> > > > > purpose
> > > > > to
> > > > > resolve such build warning reported by kernel test bot:
> > > > > https://lore.kernel.org/all/20240710123426.935122-1-neeraj.sanjay=
kale@nxp.com/
> > > >=20
> > > > I didn't see those warnings locally. They should be fixed by
> > > > using
> > > > __maybe_unused instead otherwise the "it extends the code
> > > > coverage"
> > > > justification wouldn't really apply anymore.
> > >=20
> > > Yes, I think we should mark the functions that are conditional
> > > with
> > > __maybe_unused, actually this might be the case with
> > > btusb_resume/btusb_suspend as well, right?
> >=20
> > I believe that's what I've done that in v3. Let me know if there
> > are
> > any problems with that version still.
>=20
> You mean
> https://patchwork.kernel.org/project/bluetooth/list/?series=3D1044140?
> That doesn't contain any changes to btusb though, anyway I can fixup
> the existing change just in case.

Sorry, I read that a bit quickly, you're right.

I made a bit of a mess of this patchset because I had real trouble
trying to first disabling CONFIG_PM altogether (had success with this
yesterday), and then trying to make the current btusb code throw a
warning, but couldn't.

And that's the case because pm_ptr() is based on PTR_IF() and its docs
explain why __maybe_unused isn't necessary when using pm_ptr():
https://kernel.org/doc/html//next/driver-api/basics.html#c.PTR_IF

The other patches I sent used SET_SYSTEM_SLEEP_PM_OPS() and
SET_RUNTIME_PM_OPS() which use #ifdef's.

In short, the code in btusb.c was correct, no need for fixups.

Cheers
