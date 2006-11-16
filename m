Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 16 Nov 2006 18:17:34 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061116161734.GA26803@localhost.localdomain>
References: <455C01C4.7090801@xmission.com>
	<1163672537.5169.16.camel@localhost>
	<455C8857.9050008@xmission.com>
	<1163692996.5169.67.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1163692996.5169.67.camel@localhost>
Subject: Re: [Bluez-devel] audio & dbus
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

On Thu, Nov 16, 2006, Marcel Holtmann wrote:
> > 		void RingHeadset()
> > 
> > 			Indicate a single RING to the connected headset.
> 
> No need to do this. This should be handled automatically via Play or
> some other method.

I think it's needed, or at least it can't be handled through the Play 
method. The "Send Ring to headset, get answer button press from headset" 
situation is not necessarely related to sending and receiving audio in 
general.

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
