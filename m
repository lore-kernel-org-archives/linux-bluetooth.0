Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200712192341.02293.post@hendrik-sattler.de>
References: <200712192341.02293.post@hendrik-sattler.de>
Date: Thu, 20 Dec 2007 00:34:33 +0100
Message-Id: <1198107273.8050.228.camel@aeonflux>
Mime-Version: 1.0
Cc: Hendrik Sattler <post@hendrik-sattler.de>
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

> since several versions of bluez userspace libs and utils, I am unable to 
> unregister local SDP server records. Everything I tried so far fails to 
> unregister the record:
> I use sdp_connect() and sdp_device_record_register() to register the SDP 
> record and use the return result of the latter for 
> sdp_device_record_unregister() and then sdp_close().
> 
> In earlier versions, the unregistering and explicit closing of the session 
> handle wasn't even necessary but that broke. That can be handled but 
> unregistering a record in an explicit way like above should work, doesn't it?
> 
> When the bug appeared, I though that waiting some versions might suffice. But 
> obviously, nobody ever noticed.
> Is there a possibility that this gets fixed?

not sure about that. Never heard about it. Are you using the sdpd daemon
or do you use hcid -s and the embedded SDP server?

I might have introduced a bug when switching everything over to the
embedded SDP server and the automatic service classes handling. Do you
have a simple reproducer that I can try?

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
