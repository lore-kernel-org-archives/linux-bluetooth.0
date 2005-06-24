Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] using scanner with bluez and question to
	csr-hci-commands
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OF6C4333A9.A9953808-ONC125702A.00447737-C125702A.0049AD28@dcx.dcx>
References: 
	 <OF6C4333A9.A9953808-ONC125702A.00447737-C125702A.0049AD28@dcx.dcx>
Content-Type: text/plain
Message-Id: <1119627686.7129.5.camel@notepaq>
Mime-Version: 1.0
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
Date: Fri, 24 Jun 2005 17:41:26 +0200

Hi Andreas,

> A time ago I installed csrsniff and bpasniff from cvs. I have a FTS and a
> BPA-Sniffer.
> 
> When I'm looking now into the cvs I can't find the code again. Why?

the bpasniff is mostly complete. However the master/slave switching are
not really detected and the sniffing of encrypted links is not
supported. The csrsniff is still not finished and maybe never will be.
Ask Frontline for a Linux version of the FTE software.

> Now its time for me to try using this with linux too. currently I am only
> tried the bpasniff. It works.  the outcome from the bpasniff looks like
> baseband packages.
> Have someone written some tools for decoding the packages? Or are there
> some source /info-link available for this topic?

It should decode at least LMP and feed the data into L2CAP. Maybe I have
to check again if I really committed the code. At the moment I am at the
LinuxTag and don't have the BPA-105 with me.

> Second question.
> The csr-ships supporting a lot of additional HCI-commands (I guess its
> implementation specific ...). What I have found in your CVS is the
> possibility to set the BT-Address.
> Is there someone working on getting the following HCI-commands implemented
> in bluez - at least in cvs for testing - too?
> 
> Display supported key length of the module

Use "hciconfig hci0 revision" as root.

> Display acl connection keylength

Use the "bccmd" tool.

> warm-reset Resets the module
> cold-reset Resets the module

Both are not implemented yet.

> Get or set the min keylen
> Get or set the max keylen

You can use the "pskey" tool for it.

> Get or set if a unitkey is used

Don't deal with unit keys at all. It is a security risk.

> It would be helpful for testing BT implementaions, because testing the
> black boxes from our supplier is not so easy without tools.
> Is this genrally possible - or are there some restrictions from CSR?

I can do a lot of special things for CSR chips if you need them. However
you have to ask me nicly or convice me with money or some other gifts ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
