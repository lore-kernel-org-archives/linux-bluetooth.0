Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Paul Hedderly <bulkpaul@mjr.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
Message-ID: <20050830100755.GK26701@wacka.mjr.org>
References: <e1effdeb0508220527500878ab@mail.gmail.com> <5256d0b050822053737c9cd8f@mail.gmail.com> <e1effdeb05082205517cac906c@mail.gmail.com> <9307f5f2050822072659387e3b@mail.gmail.com> <1124721252.23599.53.camel@pegasus> <e1effdeb05082210394bed468@mail.gmail.com> <1124733046.23599.81.camel@pegasus> <e1effdeb050822124710aa8798@mail.gmail.com> <e1effdeb0508291413753e3b2e@mail.gmail.com> <1125351995.17698.37.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1125351995.17698.37.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 30 Aug 2005 11:07:55 +0100

I just looked and... dbus 0.36 is in experimental currently... so
hopefully should make it to unstable RSN.

--
Paul

On Mon, Aug 29, 2005 at 11:46:35PM +0200, Marcel Holtmann wrote:
> Hi Claudio,
> 
> > Sorry annoy you again, but would like received more suggestions and
> > close this discussion.
> > 
> > Marcel, I remember you comment something about improve the sdpd, could
> > you be more clear?
> > 
> > The core implementation (bluetoothd) and some hci functions are ready.
> > I am just waiting finish the specification.
> 
> sorry, I am totally behind my schedule and as you saw, I had to deal
> with some weird D-Bus things in the current hcid in the last week. There
> is other stuff that needs my attention, before I can start looking at
> bluetoothd again.
> 
> However the basic idea is that bluetoothd should combine hcid and sdpd
> and present an easier interface over D-Bus. This interface should no
> longer be HCI or SDP protocol specific. It should be more profile
> specific and define standard task. In conjunction with the new extended
> inquiry response the bluetoothd must also take care to assemble the
> correct data from the running services and the device name to fully
> fulfil the requirements of extended inquiry response. If the complete
> SDP handling is inside bluetoothd we can do full and easy caching of
> service information of remote devices.
> 
> On the other side we have that D-Bus API problem and if anyone can
> convince the Debian guys to finally move to latest D-Bus release for the
> unstable distribution I would be really thankful. I simple wanna drop
> these crappy workaround, because they make my testing before I can
> release a new version a mess. I saw that Ubuntu even uses D-Bus 0.35 and
> so there is no other distribution with such an old version.
> 
> The next thing is the kernel interface for bluetoothd. I basically don't
> wanna have another daemon listening on the HCI socket and have to deal
> with plug/unplug of devices. These task are already done inside the
> kernel and so it should simply inform the userspace of such events. The
> same applies to connection tracking etc. The kernel needs to know
> everything and I must work on the new interface to tell the userspace
> what is currently going on. For that I will use the special HCI_DEV_NONE
> system socket and the vendor packets type 0xff. So we don't pollute the
> HCI namespace with "stack internal" commands and events and still have
> an easy interface. The other possibility would be to use netlink, but we
> already have most parts of the infrastructure in place and so I don't
> see and need to deal with netlink. And one of the first things that
> bluetoothd must be capable of is to support the kernel internal security
> manager. This means dealing with special events to handle pin code and
> link key requests.
> 
> As maybe some people saw, I already used hcid as a playground for some
> more D-Bus signals. I still need to learn and understand the D-Bus much
> better. So any patches from your specification to bring some of these
> features to hcid would be happily accepted.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
