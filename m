Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030912095921.030764b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20031008180324.059f6750@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1065716040.14513.52.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Bluetooth update for 2.4.23-pre2
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 09 Oct 2003 18:13:54 +0200

Hi Max,

> >I want to keep the the third parameter to be save in future if we need
> >to send other notifications down to the HCI driver for which we can use
> >it eventually. Bluetooth 1.2 and 2.0 will come with new stuff that may
> >need it.
> Unlikely. In any case we can add it later of needed.
> 
> >For the CONN_ADD and CONN_DEL I think we should also send the "conn"
> >down to the driver so it can read from it if needed.
> But the only thing useful for the driver is the connection type. We might as 
> well just pass that instead of a pointer to the whole struct. Anyway core should
> count connections not the driver.
> 
> >If not, it has to go by itself through the hash and I don't see any way that the 
> >driver can find out the current added connection. Am I wrong?
> conn_hash has 'num' field which is total number of connections. So we just need to
> keep two separate counters for ACL and SCO.
> I'll try to find some time this week to implement that.

I see the notify() interface and the seperate counting of ACL and SCO as
two different problems and I don't wanna mix them.

However I think it is nice to send the "conn" down to the driver, if you
thing it is two much, I drop it.

> >Yes, you told me that. And I put a note on my TODO list that this needs
> >further attention. But your suggestions was to change the credits value
> >from uint to int and don't find the time to check if a type change may
> >not causes other problems. And as I also said a new flag may be a better
> >solution.
> >Anyway I took the patch in, because it fixes the problem and whithout we
> >have a bug with incoming 1.0b connections. The double negotiation only
> >takes place on the second outgoing connections to the same 1.0b device.
> >And how much 1.0b devices do you have or do you know of? My only 1.0b
> >device is a Ericsson T39m and even my old Nokia 6210 already supports
> >CFC. And my HBH-10 don't count, because it support only one RFCOMM
> >connection ;)
> What I'm saying is that we should fix the write way not just some hack that 
> fixes first negotiation. It will pass certification with Ceticomm (or whatever 
> the name of that company) but will fail if tester code does proper checking ie second 
> connection, etc.
> It should be a trivial fix. I take a look at it tonight.

I looked at your fix and it looks fine to me. Can you please rebuild my
marcel-2.4 tree on the base of your current work? I will re-push my
other patches so we can sync up with Marcelo until the end of this week.
I want to finish this as soon as possible, because I am away for the
complete next week.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
