Return-Path: <cyrus@holtmann.org>
Message-ID: <40827.38703.qm@web303.biz.mail.mud.yahoo.com>
Date: Thu, 14 May 2009 13:17:32 -0700 (PDT)
From: Yu Kang Ku <infinity@hagao.com>
Subject: Question on hci_remote_features_evt()
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

In http://lxr.linux.no/linux+v2.6.27/net/bluetooth/hci_event.c, hci_remote_features_evt() contains the following code:

if (!ev->status && lmp_ssp_capable(hdev) &&
			lmp_ssp_capable(conn)) {
	struct hci_cp_read_remote_ext_features cp;
	cp.handle = ev->handle;
	cp.page = 0x01;
	hci_send_cmd(hdev,
		HCI_OP_READ_REMOTE_EXT_FEATURES,
				sizeof(cp), &cp);
}

Should the if-statement check to make sure LMP Extended Features is supported before sending the HCI_OP_READ_REMOTE_EXT_FEATURES command?  Or does the fact that a remote device is SSP-capable imply LMP Extended Features is supported as well?

Thanks,
Kang

