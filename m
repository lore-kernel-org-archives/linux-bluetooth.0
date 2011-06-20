Return-Path: <cyrus@holtmann.org>
From: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
To: "Li, Nami" <nami@qca.qualcomm.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Liu, Haijun" <haijun@qca.qualcomm.com>,
	"openobex-users@lists.sourceforge.net"
	<openobex-users@lists.sourceforge.net>,
	"Li, Nami" <nami@qca.qualcomm.com>
Subject: RE: [PATCH openobex 1/3] Add transport format member in fdobex_data
 struct. Support STREAM and SEQPACKET transport format.
Date: Mon, 20 Jun 2011 06:08:51 +0000
Message-ID: <480687D4EEFE7447A2E09AADFF667362049B946E@nasanexd02a.na.qualcomm.com>
References: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Nami
Sent: Monday, June 20, 2011 11:17 AM
To: linux-bluetooth@vger.kernel.org
Cc: Liu, Haijun; openobex-users@lists.sourceforge.net; Li, Nami
Subject: [PATCH openobex 1/3] Add transport format member in fdobex_data struct. Support STREAM and SEQPACKET transport format.

---
 include/openobex/obex_const.h |    4 ++++
 lib/fdobex.h                  |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

I think you should limit the number of characters in the subject to around 72 odd.
Any explanation can be added in the beginning of the patch.

Regards
Suraj
