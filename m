Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 31 Jul 2006 18:50:09 +0200
References: <200607311518.57014.dgollub@suse.de>
	<20060731132652.GA29003@localhost.localdomain>
	<1154369499.4982.6.camel@aeonflux.holtmann.net>
In-Reply-To: <1154369499.4982.6.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200607311850.09567.dgollub@suse.de>
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

On Monday 31 July 2006 20:11, Marcel Holtmann wrote:
> someone has to convince me, why the direction information is needed at
> all. If I remember correctly, then we dropped it on purpose. I simply
> don't see any useful need for it. Except maybe displaying the "incoming"
> or "outgoing" and this doesn't really have to do anything with the
> pairing process.

The pin dialog has to know if the user have to reply a pin from an incoming 
pairing request from another device (only provide a plain input field). Or if 
the pin dialog can suggest a randomly generated pin which have to be replied 
by the other device.

Example:

Outgoing Connection
The user on the computer triggers a pairing request (outgoing connection). The 
pin get randomly generated and displayed in the pairing dialog and have to 
replied by the cellphone.

Incoming Connection
The user triggers a pairing from the cellphone with the computer (incoming 
connection). A pin dialog appears on the computer with an input filed to 
reply the same pin.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
