Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>
Date: Tue, 23 Mar 2010 16:36:46 -0700
Subject: RE: [RFC] Release Plan for ERTM, Streaming Mode, FCS and SAR on
 L2CAP
Message-ID: <35B17FE5076C7040809188FBE7913F983A1DDCF3F4@SC1EXMB-MBCL.global.atheros.com>
References: <20100323203903.GA13897@vigoh>
In-Reply-To: <20100323203903.GA13897@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gus,

	My comments will be that it is probably better to implement eRTM mode first because many existing implementations do not support stream mode but definitely support eRTM mode. 

	You shall be able to verify the testing with Bluetooth SIG PTS,

Thanks,

Mike

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Gustavo F. Padovan
Sent: Tuesday, March 23, 2010 1:39 PM
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [RFC] Release Plan for ERTM, Streaming Mode, FCS and SAR on L2CAP

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
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
