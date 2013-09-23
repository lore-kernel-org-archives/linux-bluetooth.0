Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Mike Frysinger <vapier@chromium.org>,
        Hyuckjoo Lee <hyuckjoo.lee@samsung.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Date: Mon, 23 Sep 2013 12:18:48 -0700
Subject: RE: [PATCH v5 1/2] Bluetooth: btmrvl: add setup handler
Message-ID: <477F20668A386D41ADCC57781B1F70430F44C59418@SC-VEXCH1.marvell.com>
References: <1379715667-22424-1-git-send-email-bzhao@marvell.com>
 <18678858-E711-43E5-AFE6-E637D1CECFFB@holtmann.org>
In-Reply-To: <18678858-E711-43E5-AFE6-E637D1CECFFB@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> > -	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
> > +	hdev->setup =3D btmrvl_setup;
>=20
> just to make sure you guys understand how ->setup() works. It is only cal=
led once. Bringing the
> adapter down and up again does not call ->setup() a second time. So do yo=
u guys need this setup_done
> variable and if so, then you need to be a bit more verbose and help me un=
derstand why.

It's observed that sometimes the setup handler is called twice when Bluetoo=
th daemon is running in background. We will rebase to latest commit on blue=
tooth-next tree and test again. If the issue is gone with the latest code i=
n -next tree we will remove the setup_done flag.

Thanks,
Bing
