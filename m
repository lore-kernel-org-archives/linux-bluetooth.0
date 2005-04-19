Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error on connect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <426522C6.10700@gmx.ch>
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>
	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>
	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>
	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>
	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch>
	 <1113923580.2469.7.camel@pegasus>  <426522C6.10700@gmx.ch>
Content-Type: text/plain
Message-Id: <1113925620.2469.26.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Apr 2005 17:47:00 +0200

Hi Marco,

> >>If a broadcom dongle is listening, sometimes the ACL packet marked with #2# 
> >>is received where the #1# lines are. Actually, looking at the hcidump of 
> >>the sending dongle, that's the time the packet is sent (alway, dongle 
> >>independant).
> > 
> > do you have a dump where this actually happens?
> 
> the dump of the listeining or the sending dongle?
> for the listening one, I sent a hcidump from a successfull and failed 
> connection. with a diff, you see exactly what I described.

I checked the thread and I found the listening one. The handles are
matching and now I fully understand whats happening.

> >>It looks like this too early packet now causes the (sensefull) 
> >>"hci_acldata_packet: hci1 ACL packet for unknown connection handle 6" 
> >>kernel error message. The dongle then waits for this acl package and thinks 
> >>this connection is in etablishing phase, so it is blocked.
> > 
> >>From a quick look at the kernel code, it seems that an ACL packet for an
> > unknown connection handle may corrupt the HCI flow control.
> 
> I think exactly this happens...

However even if I fix the HCI flow control problem, the packet is still
lost, because we don't know the connection handle at that time.

> >>The question now is, who is responsible for holding this packed back? The 
> >>kernel? The dongle itself?
> > 
> > The dongle is responsible for that and actually it is only allowed to
> > send data packets after the "Connect Complete" event. Otherwise we don't
> > know its handle and thus can't correctly assign it to a connection.
> 
> but then it's strainge that these ACL packets are always sent before the 
> "connection" successfull packet. or do I right now miss something?

This must be a bug in the Broadcom link manager firmware. Seems like
BlueZ is "too fast" for these chips.

If you wanna workaround this problem you must put potential ACL data
packets into a queue and then check this queue after you received the
connection handle.

Does this happen with both Broadcom dongles you have? You only saw that
on the listing side, right?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
