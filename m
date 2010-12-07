Return-Path: <cyrus@holtmann.org>
From: "Brian Gix" <bgix@codeaurora.org>
To: <linux-bluetooth@vger.kernel.org>
Subject: EVT_NUM_COMP_PKTS and LE, GATT and SM
Date: Mon, 6 Dec 2010 16:35:51 -0800
Message-ID: <002501cb95a6$b350fc50$19f2f4f0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I've have encountered a problem while using the gatttool, where my write
commands get clobbered by the LE ACL being disconnected prior to the ATT
(fixed channel 4) WRITE_CMD being sent over the LE based ACL link.

I believe this is fundamentally due to there being no dependency on the
EVT_NUM_COMP_PKTS event when gatttool decides that the WRITE_CMD has been
successfully sent.  There is multiple parts to this.

1. In User space, the WRITE_CMD pkt is written to the socket.  Gatttool
erroneously considers a successful socket write as completion, disconnects
the socket and exits.

2. In Kernel space, the ACL packet is added to an ACL queue, which is
separate from the CMD queue, which can allow either the Disconnect request,
or the ACL packet to be sent over the H4 link to the baseband.

3. In the baseband, due to LE clocking (and possible other baseband
activity) the ACL packet could be received first, and the Disconnect CMD
second, and still result in the connection being detached prior to Tx of the
ACL packet containing the ATT WRITE_CMD.

This is not an issue with  any of the ATT READ/FIND/MTU or WRITE_REQ
transactions, because they require a response from the server.  I believe
for ATT, this problem is restricted to the WRITE_CMD only, due to it's
unacknowledged nature.

However, this will also be an issue with the LE Security Manager, because as
stated in the Core Spec v4.0, Vol 3, in the last paragraph of 3.6.1 Key
Distribution on page 630 (of 656):

	> Key distribution is complete in the device sending the final key
when it receives
	> the baseband acknowledgement for that key and is complete in the
receiving
	> device when it receives the final key being distributed.

This is intended to prevent exactly the kind of problem I am experiencing
with the ATT WRITE_CMD, and the acknowledgement from the baseband can only
be the EVT_NUM_COMP_PKTS event.

While talking to my colleagues here, we were thinking that the cleanest
method to get this accomplished would be by using the "select" method with
the ATT socket, where the socket could be marked as non-writable by the
kernel driver until the EVT_NUM_COMP_PKTS is received. The User space code
could then wait for the socket to become writeable before issuing the socket
disconnect.

If the Security manager is totally within the kernel, it probably does not
have to do as much work, however it does still need to wait on the
EVT_NUM_COMP_PKTS before disconnecting the remote device.

Has anybody else observed this issue with ATT WRITE_CMD? It could be getting
exacerbated by slow (115Kbps) H4 links that I am using, however the hcidump
tool confirms that the disconnect happens prior to the EVT_NUM_COMP_PKTS.


	
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



