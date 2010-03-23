Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Tue, 23 Mar 2010 17:39:03 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [RFC] Release Plan for ERTM, Streaming Mode, FCS and SAR on L2CAP
Message-ID: <20100323203903.GA13897@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi People,

I was thinking about a release plan for Enhanced Retransmission Mode,
Streaming Mode, Frame Check Sequence(FCS) and Segmentation and
Reassembly(SAR).

2.6.35: Upstream Streaming Mode, FCS, SAR and add a sub-menu option
to L2CAP at Kconfig for ERTM with an EXPERIMENTAL flag. So we will have
a chance to test ERTM more intensively.

2.6.36: Upstream ERTM. After that ERTM will be the default mode with
SOCK_STREAM and also enabled by default under L2CAP. If you think it's
not worth release Streaming Mode, FCS and SAR without ERTM we can
upstream them together on 2.6.36.

Comments, ideas?

-- 
Gustavo F. Padovan
http://padovan.org
