Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060731132652.GA29003@localhost.localdomain>
References: <200607311518.57014.dgollub@suse.de>
	<20060731132652.GA29003@localhost.localdomain>
Date: Mon, 31 Jul 2006 20:11:39 +0200
Message-Id: <1154369499.4982.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Addition for hcid passkey dbus request
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

Hi Johan,

> > i am started working for the bluez dbus integration for kdebluetooth. The 
> > kdebluetooth pin dialog for pairing has a pin generation feature for outgoing 
> > pairing requests. This requires that hcid also provides connection 
> > information about the pairing. A hcid patch is attached, which sends a 
> > enhanced passkey request with the connection direction. This requires changes 
> > on all application which handle as passkey agents. Is there a better solution 
> > expect dropping the pin generation feature?
> 
> I think a better solution could be to add a new method to hcid for 
> querying the connection direction (it would take the local adapter path 
> and remote address as parameters). This way the current passkey agent 
> interface would not have to be changed.

someone has to convince me, why the direction information is needed at
all. If I remember correctly, then we dropped it on purpose. I simply
don't see any useful need for it. Except maybe displaying the "incoming"
or "outgoing" and this doesn't really have to do anything with the
pairing process.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
