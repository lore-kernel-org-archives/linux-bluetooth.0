Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Apr 2014 11:01:09 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"Xu, Martin" <martin.xu@intel.com>,
	"Wu, JiangboX" <jiangbox.wu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Interface and the other properties is not provided when BT pan
 (NAP) is connected passively
Message-ID: <20140401080109.GA18614@t440s.lan>
References: <2CF57A644018A745B8FE029C7223E16E1185AD06@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E1185AD06@SHSMSX104.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zheng Wu,

On Tue, Apr 01, 2014, Zheng, Wu wrote:
> We find that "org.bluez.NetworkServer1" doesn't provide any properties.
> 
> Only "org.bluez.Network1" provides the related properties.
> 
> It means that BT PANU or BT NAP connects with the other BT pan devices actively.
> The related BT properties (such as interface) can be provided.

By "interface" I assume you mean "network interface"? (to avoid
confusion e.g. with "D-Bus interface").

> However, If BT NAP is connected passively, The related BT properties
> (such as interface) can't be provided.
> 
> In TIZEN scene, the related BT properties (such as interface) is
> required when BT NAP is connected passively.

To my understanding that shouldn't be needed. You provide a bridge name
when you call NetworkServer1.Register() and new connections are
automatically added to that bridge. What else do you need?

Johan
