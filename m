Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 23 Oct 2006 22:50:13 +0200
References: <7aabaf0e0610230427m2f8bfa5ekcfe2ce2fc9f165f1@mail.gmail.com>
	<1161618279.10866.102.camel@aeonflux.holtmann.net>
	<7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
In-Reply-To: <7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200610232250.13988.dgollub@suse.de>
Subject: Re: [Bluez-devel] Pin for an outgoing connection
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

On Monday 23 October 2006 16:02, Valentine Sinitsyn wrote:
> Sure - I have some experience developing D-BUS applications. ;-) I
> only guess that (as we already have passkey-agent for GNOME and I'm
> running KDE) this should be done within the kdebluetooth framework so
> I'd better ask kdebluetooth team if they need one (and not developing
> it till now, which would be surprise for me).

Hi Valentine,

i started porting the kdebluetooth framework to the new blueZ DBus API.  All 
DBus methods are implemented in a new libkbluetooth. I dropped kbluetoothd 
and replaced (forked) it with kbluetooth. So far it only acts as passkey 
agent. Also the porting of the kcm_btpaired is nearly done...
At the moment i am trying to get kiobluetooth working with the new 
libkbluetooth.

The kdebluetooth branch for the blueZ DBus API can be found in the KDE SVN:
http://websvn.kde.org/branches/work/kdebluetooth-dbus-integration/

I will announce further procceding, of this development, in the end of this 
week. So far i didn't find time for this, Sorry. But i would appreciate any 
help in this development.

best regards,
Daniel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
