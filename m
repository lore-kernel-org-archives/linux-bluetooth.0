Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP dropping packets on BlueZ based receiver
References: <200408021859.44496.harbaum@beecon.de> <1091472875.4259.6.camel@pegasus>
In-Reply-To: <1091472875.4259.6.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408031223.11789.harbaum@beecon.de>
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
Date: Tue, 3 Aug 2004 12:23:11 +0200

Hi Marcel,

On Monday 02 August 2004 20:57, Marcel Holtmann wrote:
> Some Bluetooth stacks emulate L2CAP flow control with the flow control
> of the HCI layer, but this is more bad than dropping a packet. Actually
> this is the reason why most mobiles phones don't support more than one
> ACL at the same time.
Hmm ... you are right. I have been implementing l2cap and have never really 
faced this problem. In fact i have been using HCI layer flow control to have 
a reliable L2CAP layer and thus, one blocking L2CAP client will affect all 
clients.

> The solution for this is using RFCOMM or L2CAP with retransmission and
> flow control from the Bluetooth 1.2 specification.
It's been some time since i wrote my rfcomm layer, but i didn't remember 
rfcomm having a sequence number or the like and IMHO it does not have a 
mechanism for retransmission. Or have i really missed something that 
important?

IMHO you can use rfcomm to make the whole transmission reliable, but this 
means, that you have to use acl flow control and make sure, that l2cap/acl 
won't block via rfcomms credit based flow control. Are there other options?

Thanks for your hints so far.

Till

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
