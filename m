Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2009 13:45:36 +0800
Message-ID: <a172fe730903302245k1bb2209ag371e07d4a0cbbb80@mail.gmail.com>
Subject: eSCO or SCO link?
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
 I have a stlc2500c which is a Bluetooth 1.2 chip. When debuging
function 'hci_connect', i found the hci link type of the arguments was
SCO_LINK, because i enabled 'lmp_esco_capable' in my kernel, it call
'hci_setup_sync' to setup eSCO link.
struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t
*dst, __u8 auth_type)
{
        .....
	if (lmp_esco_capable(hdev))
	{
		hci_setup_sync(sco, acl->handle);
	}			
	else
	{
		hci_add_sco(sco, acl->handle);
	}
		
}
