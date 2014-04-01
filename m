Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Hedberg, Johan" <johan.hedberg@intel.com>
CC: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"Xu, Martin" <martin.xu@intel.com>,
	"Wu, JiangboX" <jiangbox.wu@intel.com>,
	"'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: RE: Interface and the other properties is not provided when BT pan
 (NAP) is connected passively
Date: Tue, 1 Apr 2014 08:37:05 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E1185B07C@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E1185AD06@SHSMSX104.ccr.corp.intel.com>
 <20140401080109.GA18614@t440s.lan>
In-Reply-To: <20140401080109.GA18614@t440s.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>By "interface" I assume you mean "network interface"? (to avoid confusion e.g. with "D-Bus interface")
Yes. "interface" is such as "bnep0", "bnep1" and so on.

>To my understanding that shouldn't be needed. You provide a bridge name when you call NetworkServer1.Register() and new connections are automatically added to that bridge. What else do you need?
We want to get " network interface" such as "bnep0", "bnep1" and so on, not bridge name(such as "tether" and so on).

Just like that the properties of "org.bluez.Network1" provides " network interface " such as "bnep0", "bnep1" after bnep connection successfully.

Best Regards
Zheng Wu

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Johan Hedberg
Sent: Tuesday, April 1, 2014 4:01 PM
To: Zheng, Wu
Cc: Von Dentz, Luiz; Xu, Martin; Wu, JiangboX; linux-bluetooth@vger.kernel.org
Subject: Re: Interface and the other properties is not provided when BT pan (NAP) is connected passively

Hi Zheng Wu,

On Tue, Apr 01, 2014, Zheng, Wu wrote:
> We find that "org.bluez.NetworkServer1" doesn't provide any properties.
> 
> Only "org.bluez.Network1" provides the related properties.
> 
> It means that BT PANU or BT NAP connects with the other BT pan devices actively.
> The related BT properties (such as interface) can be provided.

By "interface" I assume you mean "network interface"? (to avoid confusion e.g. with "D-Bus interface").

> However, If BT NAP is connected passively, The related BT properties 
> (such as interface) can't be provided.
> 
> In TIZEN scene, the related BT properties (such as interface) is 
> required when BT NAP is connected passively.

To my understanding that shouldn't be needed. You provide a bridge name when you call NetworkServer1.Register() and new connections are automatically added to that bridge. What else do you need?

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
