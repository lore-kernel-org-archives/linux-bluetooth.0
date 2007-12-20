Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <20071220102046.7h0duacmskwgkc8g@v1539.ncsrv.de>
References: <200712192341.02293.post@hendrik-sattler.de>
	<1198107273.8050.228.camel@aeonflux>
	<200712200229.40589.post@hendrik-sattler.de>
	<1198116580.8050.232.camel@aeonflux>
	<20071220102046.7h0duacmskwgkc8g@v1539.ncsrv.de>
Date: Thu, 20 Dec 2007 16:08:52 +0100
Message-Id: <1198163332.8050.250.camel@aeonflux>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SDP services cannot be unregistered
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Hendrik,

> > first of all you are using the unregister function wrongly. You have to
> > give it the exact record structure you gave the register function. So
> > when you allocate a new record, then the unregister has no idea what to
> > do with it.
> 
> bt_sdp_obexpush() does create a new record structure but with the  
> exact same parameters (actually no variable parameters at all). The  
> resulting records should fully match, at least I assume that. The  
> record ID is then stored in the session_t value, I assume.
> Or are pointer addresses matched, too?

doesn't work like that. The magic is the record->handle and nothing
else. However that might change. So the safest way is to have a static
variable for the record that stores it for the lifetime of the daemon.

> > Why it doesn't cleanup after program termination is unclear to me. That
> > should actually work. You might wanna investigate on that one.
> 
> Before this came up, I did not unregister or close at all and  
> everything was fine when the program was killed (SDP record was gone).
> Can you give me a hint where this is actually processed, bluez-libs or  
> bluez-utils?

It is processed in bluez-utils/sdpd/, but be aware of that this code is
really tricky. I am about to actually remove it at some point. Not sure
when and how though.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
