Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jun 2010 17:16:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Counihan, Tom" <tom.counihan@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Proposed MAP client D-Bus API (was: Proposed MAP API)
Message-ID: <20100614141605.GA27414@jh-x301>
References: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
 <20100614091849.GA20885@jh-x301>
 <B09AD526409DF14F8DA79CC5429052C28F7AAD48@irsmsx505.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B09AD526409DF14F8DA79CC5429052C28F7AAD48@irsmsx505.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Mon, Jun 14, 2010, Counihan, Tom wrote:
> Many thanks for the prompt response Johan,

No problem :)

> Not sure at all really. I had my suspicion, but wanted to start somewhere.
> What you suggest makes perfect sense really - back to the drawing
> board for me :$ - just need to figure out a logical home for this.

Note that I'm not strictly saying that it can't be D-Bus based. Only
that there's a considerable risk with that and that you should
understand the pros and cons of the different alternatives. E.g.
compared to D-Bus a library would restrict you more in terms of what
programing languages can be used for the application whereas there's
quite a plethora of D-Bus bindings out there. You'd also need to
consider potential multithreading issues and pay close attention in
designing the API so that it can be conveniently hooked up to whatever
mainloop the application has, or then simply decide that only one
mainloop, e.g. the glib one, is supported.

> On an aside, could the same comment be made regarding PBAP re contact
> pictures?

Yes, I think so.

Johan
