Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"Xu, Martin" <martin.xu@intel.com>,
	"Wu, JiangboX" <jiangbox.wu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Interface and the other properties is not provided when BT pan
 (NAP) is connected passively
Date: Tue, 1 Apr 2014 02:20:22 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E1185AD06@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan;

We find that "org.bluez.NetworkServer1" doesn't provide any properties.

Only "org.bluez.Network1" provides the related properties.

It means that BT PANU or BT NAP connects with the other BT pan devices actively.
The related BT properties (such as interface) can be provided.

However, If BT NAP is connected passively, The related BT properties (such as interface) can't be provided.

In TIZEN scene, the related BT properties (such as interface) is required when BT NAP is connected passively.

How can we get the related BT properties?

Can you provide some suggestion? Thanks.

Best Regards
Zheng Wu
