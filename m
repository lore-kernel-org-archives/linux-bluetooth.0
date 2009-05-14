Return-Path: <cyrus@holtmann.org>
Subject: Re: Question on hci_remote_features_evt()
From: Marcel Holtmann <marcel@holtmann.org>
To: Yu Kang Ku <infinity@hagao.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <40827.38703.qm@web303.biz.mail.mud.yahoo.com>
References: <40827.38703.qm@web303.biz.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 14 May 2009 13:26:52 -0700
Message-Id: <1242332812.27899.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kang,

> In http://lxr.linux.no/linux+v2.6.27/net/bluetooth/hci_event.c, hci_remote_features_evt() contains the following code:
> 
> if (!ev->status && lmp_ssp_capable(hdev) &&
> 			lmp_ssp_capable(conn)) {
> 	struct hci_cp_read_remote_ext_features cp;
> 	cp.handle = ev->handle;
> 	cp.page = 0x01;
> 	hci_send_cmd(hdev,
> 		HCI_OP_READ_REMOTE_EXT_FEATURES,
> 				sizeof(cp), &cp);
> }
> 
> Should the if-statement check to make sure LMP Extended Features is supported before sending the HCI_OP_READ_REMOTE_EXT_FEATURES command?  Or does the fact that a remote device is SSP-capable imply LMP Extended Features is supported as well?

if you support SSP, you have to support extended features. The host
features bits for SSP are in the second features page and thus it is
required to support this.

Regards

Marcel


