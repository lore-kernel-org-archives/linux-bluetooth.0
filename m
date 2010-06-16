Return-Path: <cyrus@holtmann.org>
From: "Counihan, Tom" <tom.counihan@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Jun 2010 13:02:51 +0100
Subject: RE: Proposed MAP client D-Bus API (was: Proposed MAP API)
Message-ID: <B09AD526409DF14F8DA79CC5429052C28F8C023E@irsmsx505.ger.corp.intel.com>
References: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
 <20100614091849.GA20885@jh-x301>
 <B09AD526409DF14F8DA79CC5429052C28F7AAD48@irsmsx505.ger.corp.intel.com>
 <20100614141605.GA27414@jh-x301>
In-Reply-To: <20100614141605.GA27414@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Johan,

I'll attempt to get something kick started on gitorious along the lines of your suggestion.

Warm regards
Tom.

>-----Original Message-----
>From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
>Sent: 14 June 2010 15:16
>To: Counihan, Tom
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: Proposed MAP client D-Bus API (was: Proposed MAP API)
>
>Hi Tom,
>
>On Mon, Jun 14, 2010, Counihan, Tom wrote:
>> Many thanks for the prompt response Johan,
>
>No problem :)
>
>> Not sure at all really. I had my suspicion, but wanted to start
>somewhere.
>> What you suggest makes perfect sense really - back to the drawing
>> board for me :$ - just need to figure out a logical home for this.
>
>Note that I'm not strictly saying that it can't be D-Bus based. Only
>that there's a considerable risk with that and that you should
>understand the pros and cons of the different alternatives. E.g.
>compared to D-Bus a library would restrict you more in terms of what
>programing languages can be used for the application whereas there's
>quite a plethora of D-Bus bindings out there. You'd also need to
>consider potential multithreading issues and pay close attention in
>designing the API so that it can be conveniently hooked up to whatever
>mainloop the application has, or then simply decide that only one
>mainloop, e.g. the glib one, is supported.
>
>> On an aside, could the same comment be made regarding PBAP re contact
>> pictures?
>
>Yes, I think so.
>
>Johan
--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


