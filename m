Return-Path: <cyrus@holtmann.org>
Message-ID: <1333461650.1870.289.camel@aeonflux>
Subject: Re: [PATCH v1] Bluetooth: Fix packet type for ESCO Link
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>
Date: Tue, 03 Apr 2012 07:00:50 -0700
In-Reply-To: <CACj007nj+fpeHV=KPsp2D-G_z=ixJuK-+5=XxNuR-x0Y5auRmw@mail.gmail.com>
References: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
	 <1333460117.1870.287.camel@aeonflux>
	 <CACj007nj+fpeHV=KPsp2D-G_z=ixJuK-+5=XxNuR-x0Y5auRmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> >> This patch fixes the packet type for ESCO Link which was incorrectly
> >> set for EDR ESCO Packet Types. Anding esco_type with ~EDR_ESCO_MASK
> >> results in loosing information of esco packet type (EDR Packet
> >> types are inverted as per BT Spec) that resulted in wrong calculation
> >> of packet type in hci_setup_sync() API causing the HCI Setup Synchronous
> >> Connection Command to fail.
> >
> > any chance you can add a hcidump trace to the commit message to show
> > this failure?
> >
> I am attaching the hcicump Logs, that can be viewed in Capture File
> Viewer of FTS.
> In that the problem can be seen in HCI Tab, Frame # 619, where the
> packet type is
> incorrect resulting in command failure with error code 0x1a.

so me installing a Windows to just view the logs is not going to
happen ;)

Since you run BlueZ on one side, please just create a hcidump trace. If
you store them in BTSnoop format, you can open it with FTS as well.

Regards

Marcel


