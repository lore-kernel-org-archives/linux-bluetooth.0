Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Fix compilation with --disable-sap and glib < 2.28
Date: Tue, 19 Jul 2011 08:04:27 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>
References: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com> <20110718211327.GA27879@dell.ger.corp.intel.com>
In-Reply-To: <20110718211327.GA27879@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107190804.28045.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi,

> Thanks, the patch has been upstream (after I rewrote the commit message
> since I don't see how this has anything to do with SAP).

I added sap in commit message because build failure was triggered by 
./bootstrap-configure --disable-sap  (now sure why though:)

-- 
BR
Szymon Janc
