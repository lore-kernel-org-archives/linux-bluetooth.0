Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: [RFC 0/7] L2CAP fragmentation changes
Date: Tue, 10 Aug 2010 12:14:57 -0700
Message-Id: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Since the previous L2CAP patch set has not been fully merged, I'm only
posting these patches for review at this time.

ERTM and streaming mode currently have a limitation where the
trasmitted PDU size cannot exceed the HCI MTU.  This is a problem with
some basebands with small HCI MTU values (some are around 300 bytes),
since it is not possible to use larger BR/EDR packets over the air
when the PDUs are too small.  Bandwidth is also wasted with extra
L2CAP header overhead.  Patches 1-3 add the capability to calculate
checksums on PDUs that have HCI continuation fragments.

Patches 4-6 change the way ERTM PDUs are reassembled, to avoid 
extra data copying at receive time.  At higher AMP data rates,
this efficiency improvement becomes more important.  Each PDU
is linked together using skbuff fragments, similar to the way
outgoing data uses skbuff frag_lists for HCI continuations.  This 
way, L2CAP must only copy the data to a linear buffer when it
is copied out to userspace.

Patch 7 changes the max PDU size configuration to allow larger PDU
sizes to be set up, enabling ERTM and streaming mode to send larger
PDUs.
