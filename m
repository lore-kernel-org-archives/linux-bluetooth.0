Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jun 2010 12:18:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Counihan, Tom" <tom.counihan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Proposed MAP client D-Bus API (was: Proposed MAP API)
Message-ID: <20100614091849.GA20885@jh-x301>
References: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Mon, Jun 14, 2010, Counihan, Tom wrote:
> Please find below proposed Bluetooth MAP API, based upon Message
> Access Profile, ver 10r00. 

It'd have been good to clearly state that you're only talking about the
client side of MAP (it became clear to me only after noticing that
you've got org.openobex.client in the D-Bus API). The server side would
e.g. be implemented through an obexd plugin.

> Comments most welcome. 
> Of note below is missing the PushMessage function - Section 5.8 of
> mentioned spec.
> Reason being, I'm trying to get my head around what should be returned
> from a GetMessage call below, and conversely what should be passed to
> a potential PushMessage - bMessage can take on a number of different
> guises. 
> Any guidance/opinion would be greatly appreciated in this area, or any
> other suggested improvements.

Are you sure you want to use D-Bus for this? I suspect the required
bandwidth will be too high to be efficiently handled using D-Bus.
Wouldn't a MAP specific library on top of OpenOBEX make more sense?

Johan
