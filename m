Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099061231.10164.62.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Oct 2004 16:47:11 +0200

Hi Abhi,

> Service level security is required for JSR-82 like Steve pointed it out. 
> For anyone implementing JSR-82, they would have to add this service level
> security themselves. It would be most useful to have it as part of bluez
> rather than have people implement their own way of it. 

actually you can't implement it in a sane way in userspace, because you
don't have control over the RFCOMM signalling channel.

> Marcel, if you recall, we've exchanged an email regarding service level security. At that point, you had mentioned thinking about a security manager embedded in bluez that would allow it.

This is a little bit different, because this is more basic stuff. You
need to integrate the trigger points of the Bluetooth security mechanism
into the RFCOMM layer. And actually the state machine of RFCOMM is more
complex than the one of L2CAP. For me it is not clear at the moment what
is the best thing to do without breaking anything.

So the question still stands. Should we already force authentication
when the peer sends PN CMD?

> I am currently working on implementing JSR-82 which requires this level 
> of security. If anyone has already implemented or has a good way of doing it,
> please let me know. I would be very interested.

As mentioned above the only way is inside the kernel, because otherwise
you will trigger after the MSC exchange and this is too late.

> Also, currently there is no service level security in l2cap for outgoing
> connections. I would like to know if someone has already taken a stab at it
> and if this should be part of bluez in the future. 

You must convince me that this is really needed and a good idea. For
what kind of application do you wanna use it?

Regards

Marcel




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
