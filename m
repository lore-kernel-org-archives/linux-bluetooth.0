Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061210141620.GB3730@163.com>
References: <20061207183707.GA15790@163.com>
	<1165573434.5529.22.camel@aeonflux.holtmann.net>
	<20061209014807.GC3119@163.com>
	<1165754471.22251.17.camel@aeonflux.holtmann.net>
	<20061210141620.GB3730@163.com>
Date: Sun, 10 Dec 2006 15:20:10 +0100
Message-Id: <1165760410.20427.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] on which level does hcidump work?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> > > > > I'm encountering a problem that the data I sent through a L2CAP socket
> > > > > on my local machine doesn't appear in the output of hcidump on the
> > > > > remote machine. But it does appear in the output of hcidump on my
> > > > > local machine.
> > > > > 
> > > > > So I'm wondering on which level does hcidump work. Does it work on the
> > > > > host-dongle interface? What should I do if I want to monitor all the
> > > > > information pass through the host-dongle interface(HCI_USB?). Or can I
> > > > > make such an assumption that all the data showed in the output of
> > > > > hcidump were sent out through the radio? Can I make such a assumption
> > > > > that all the data received was showed up in the output of hcidump?
> > > > 
> > > > you see only HCI packets (hence the name). There is no real way to make
> > > > sure the packet went over the air. In some cases you can make this
> > > > assumption from other stuff that is going on.
> > > > 
> > > Then how can I make sure that the HCI ACL Packet sent by the Host is
> > > *really* received correctly by Host Controller? It seems like there
> > > doesn't exist any packet acknowlegment sent from the Host Controller.
> > > And there isn't a Command-Complete or Command-Status Event for HCI
> > > ACL Packet. So should I ensure that the HCI Transport Layer is reliable?
> > > I just want to make sure that the Packet I sent through HCI actually
> > > reached the Host Controller.
> > 
> > that is the job of the HCI transport layer and not the job of the host
> > stack. The host stack simply assumes that the transport is reliable and
> > handles packet loss etc.
> > 
> > However ACL packets are bound to the HCI flow control and you will see
> > the number of packets acknowledgment.
> This method seems feasible. I'll try it and find whether the packet
> loss be due to the HCI USB transport layer.

the HCI USB transport layer will retransmit packets on errors and have
an acknowledgment mechanism. Depending on the USB controller you use
this might be in hardware or in software. Check the USB specification
for further details.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
