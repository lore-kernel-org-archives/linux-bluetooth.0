Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7aabaf0e0610232051tf63d088tfcb1dc83a6691454@mail.gmail.com>
Date: Tue, 24 Oct 2006 09:51:52 +0600
From: "Valentine Sinitsyn" <valentine.sinitsyn@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200610232250.13988.dgollub@suse.de>
MIME-Version: 1.0
References: <7aabaf0e0610230427m2f8bfa5ekcfe2ce2fc9f165f1@mail.gmail.com>
	<1161618279.10866.102.camel@aeonflux.holtmann.net>
	<7aabaf0e0610230702g57ce1f37y87c1cc961e692612@mail.gmail.com>
	<200610232250.13988.dgollub@suse.de>
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

Hi Daniel,

On 10/24/06, Daniel Gollub <dgollub@suse.de> wrote:
> On Monday 23 October 2006 16:02, Valentine Sinitsyn wrote:
> > Sure - I have some experience developing D-BUS applications. ;-) I
> > only guess that (as we already have passkey-agent for GNOME and I'm
> > running KDE) this should be done within the kdebluetooth framework so
> > I'd better ask kdebluetooth team if they need one (and not developing
> > it till now, which would be surprise for me).

> i started porting the kdebluetooth framework to the new blueZ DBus API.  All
> DBus methods are implemented in a new libkbluetooth. I dropped kbluetoothd
> and replaced (forked) it with kbluetooth. So far it only acts as passkey
> agent. Also the porting of the kcm_btpaired is nearly done...
> At the moment i am trying to get kiobluetooth working with the new
> libkbluetooth.
>
> The kdebluetooth branch for the blueZ DBus API can be found in the KDE SVN:
> http://websvn.kde.org/branches/work/kdebluetooth-dbus-integration/
>
> I will announce further procceding, of this development, in the end of this
> week. So far i didn't find time for this, Sorry. But i would appreciate any
> help in this development.
Great - I'll check out the code and look how much has changed since
February - it was the last time I was looking at kdebluetooth tree. :)

I'll be out for the business trip till the end of the week. I'll try
to read the code in the train :) and be back right to your anouncement
-- we'll see if (and how) I can help you with this development.

-- 
Regards,
Valentine Sinitsyn

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
