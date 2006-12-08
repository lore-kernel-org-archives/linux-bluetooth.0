Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061207183707.GA15790@163.com>
References: <20061207183707.GA15790@163.com>
Date: Fri, 08 Dec 2006 11:23:54 +0100
Message-Id: <1165573434.5529.22.camel@aeonflux.holtmann.net>
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

> I'm encountering a problem that the data I sent through a L2CAP socket
> on my local machine doesn't appear in the output of hcidump on the
> remote machine. But it does appear in the output of hcidump on my
> local machine.
> 
> So I'm wondering on which level does hcidump work. Does it work on the
> host-dongle interface? What should I do if I want to monitor all the
> information pass through the host-dongle interface(HCI_USB?). Or can I
> make such an assumption that all the data showed in the output of
> hcidump were sent out through the radio? Can I make such a assumption
> that all the data received was showed up in the output of hcidump?

you see only HCI packets (hence the name). There is no real way to make
sure the packet went over the air. In some cases you can make this
assumption from other stuff that is going on.

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
