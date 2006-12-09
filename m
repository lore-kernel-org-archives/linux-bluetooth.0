Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 9 Dec 2006 09:48:07 +0800
From: amateur <ztl.post@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061209014807.GC3119@163.com>
References: <20061207183707.GA15790@163.com>
	<1165573434.5529.22.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1165573434.5529.22.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] on which level does hcidump work?
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

On Fri, Dec 08, 2006 at 11:23:54AM +0100, Marcel Holtmann wrote:
> Hi,
> 
> > I'm encountering a problem that the data I sent through a L2CAP socket
> > on my local machine doesn't appear in the output of hcidump on the
> > remote machine. But it does appear in the output of hcidump on my
> > local machine.
> > 
> > So I'm wondering on which level does hcidump work. Does it work on the
> > host-dongle interface? What should I do if I want to monitor all the
> > information pass through the host-dongle interface(HCI_USB?). Or can I
> > make such an assumption that all the data showed in the output of
> > hcidump were sent out through the radio? Can I make such a assumption
> > that all the data received was showed up in the output of hcidump?
> 
> you see only HCI packets (hence the name). There is no real way to make
> sure the packet went over the air. In some cases you can make this
> assumption from other stuff that is going on.
> 
Then how can I make sure that the HCI ACL Packet sent by the Host is
*really* received correctly by Host Controller? It seems like there
doesn't exist any packet acknowlegment sent from the Host Controller.
And there isn't a Command-Complete or Command-Status Event for HCI
ACL Packet. So should I ensure that the HCI Transport Layer is reliable?
I just want to make sure that the Packet I sent through HCI actually
reached the Host Controller.

-- 
You will be given a post of trust and responsibility.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
