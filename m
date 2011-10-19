Return-Path: <cyrus@holtmann.org>
From: "Kumar, Sunil A" <sunil.a.kumar@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 19 Oct 2011 01:59:26 -0700
Subject: Baseband Packet Type for Mobile Terminated (incoming) ACL
 Connection.
Message-ID: <5D9D8931B4C84345B8A50CA879B0CE195BD2CE12@fmsmsx501.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We are facing a problem wherein controller always uses DM1 baseband packets for outgoing ACL traffic in case of MT connection. The issue is because host doesn't change the packet types to be used after MT connection is up if HCI_Version is >= 3 (Bluetooth Core Specification 2.0 + EDR) and hence controller uses the default (DM1) baseband packets. The relevant code from hci_event.c is pasted below:

       if (!conn->out && hdev->hci_ver < 3) {
            struct hci_cp_change_conn_ptype cp;
            cp.handle = ev->handle;
            cp.pkt_type = cpu_to_le16(conn->pkt_type);
            hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE,
                            sizeof(cp), &cp);
        }

Also, controller seems to be doing right thing here by using DM1 packets as specification for HCI_Change_Connection_Packet_Type and HCI_Create_Connection states that:

"When sending HCI ACL Data Packets the Link Manager shall only use the packet type(s) specified by the Packet_Type command parameter or the always-allowed DM1 packet type."

Could someone let us know if there is an alternate way to configure the packet types to be used by controller for MT connection and what are the basis/reference for this implementation in Bluez means not to change the packet types if HCI_Version is >= 3? I tried to find the information from specification but could not find any information there.
Thanks.

Best Regards
Sunil Kumar


