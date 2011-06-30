Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: L2CAP connection on insecure link
Date: Thu, 30 Jun 2011 14:32:24 +0530
Message-ID: <A3D770027F3D024D8AA74E0D0C630813038FAC31@PNE-HJN-MBX02.wipro.com>
From: <tejaswini.purandare@wipro.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We are facing an issue as below. 

Problem statement:
This is with reference to the patch http://kernel.ubuntu.com/git?p=ubuntu/linux-2.6/.git;a=commit;h=e7c29cb16c833441fd2160642bb13025f4e7ac70 for handling L2CAP connection requests on an insecure link. I am pasting below the details of this patch.

"The Security Mode 4 of the Bluetooth 2.1 specification has strict authentication and encryption requirements. It is the initiators job to create a secure ACL link. However in case of malicious devices, the acceptor has to make sure that the ACL is encrypted before allowing any kind of L2CAP connection. The only exception here is the PSM 1 for the service discovery protocol, because that is allowed to run on an insecure ACL link.
Previously it was enough to reject a L2CAP connection during the connection setup phase, but with Bluetooth 2.1 it is forbidden to do any L2CAP protocol exchange on an insecure link (except SDP).
The new hci_conn_check_link_mode() function can be used to check the integrity of an ACL link. This functions also takes care of the cases where Security Mode 4 is disabled or one of the devices is based on an older specification."

On receipt of a L2CAP_Connect_Req (function l2cap_connect_req()), the function hci_conn_check_link_mode() checks is encryption is enabled on the link when SSP is enabled. If encryption is not yet enabled then the function l2cap_connect_req() returns L2CAP_Connect_Rsp with error Security Block. 

Due to this patch, if the HCI encryption change event arrives after the Initiator sends the L2CAP Connection Request, then the connection request is rejected with response Security Block.

Query: 
I wanted to know if this can be handled by sending an L2CAP Connection response with Connection Pending and on receiving the Encryption Change event send the L2CAP Connection response with success; else with error Security Block. 

Can you please let me know? 

Regards,
Tejaswini

