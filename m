Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200607311850.09567.dgollub@suse.de>
References: <200607311518.57014.dgollub@suse.de>
	<20060731132652.GA29003@localhost.localdomain>
	<1154369499.4982.6.camel@aeonflux.holtmann.net>
	<200607311850.09567.dgollub@suse.de>
Date: Mon, 31 Jul 2006 21:17:52 +0200
Message-Id: <1154373472.4982.21.camel@aeonflux.holtmann.net>
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

Hi Daniel,

> > someone has to convince me, why the direction information is needed at
> > all. If I remember correctly, then we dropped it on purpose. I simply
> > don't see any useful need for it. Except maybe displaying the "incoming"
> > or "outgoing" and this doesn't really have to do anything with the
> > pairing process.
> 
> The pin dialog has to know if the user have to reply a pin from an incoming 
> pairing request from another device (only provide a plain input field). Or if 
> the pin dialog can suggest a randomly generated pin which have to be replied 
> by the other device.
> 
> Example:
> 
> Outgoing Connection
> The user on the computer triggers a pairing request (outgoing connection). The 
> pin get randomly generated and displayed in the pairing dialog and have to 
> replied by the cellphone.
> 
> Incoming Connection
> The user triggers a pairing from the cellphone with the computer (incoming 
> connection). A pin dialog appears on the computer with an input filed to 
> reply the same pin.

you can't bind incoming or outgoing connections with the assumption that
this implies the initiator of the authentication request. It is not
working this way. Both are two independent procedures (except for
security mode 3, which is not really supported by BlueZ anymore).

So if you wanna have a random key generated on one side, then you need
to be the initiator of the pairing request. This can be achieved with
calling CreateBonding() and in this case you can register a device
specific passkey agent to create your random number.

The default passkey agent is really meant to be default. It will do the
same task for every pairing request. If you need a specific, like random
number or fixed PIN then use a per device passkey agent.

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
