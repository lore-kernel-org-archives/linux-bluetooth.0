Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7aabaf0e0610290201x4364481br37650136406656c2@mail.gmail.com>
Date: Sun, 29 Oct 2006 15:01:51 +0500
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

> I will announce further procceding, of this development, in the end of this
> week. So far i didn't find time for this, Sorry. But i would appreciate any
> help in this development.
It's a weekend and I'm back from my trip ;-)
as far as I understand from the code, the task is to port
kbtobexclient, kobex and other apps & libs which are not compiling now
to the new D-BUS API? I can help with this development but I think
some coordination is needed so we wouldn't be porting the same code
twice.:) Besides, it would be useful to have a smal document
describing api changes from old libkdebluetooth to the new, DBUS-based
(like what's the difference between RFCOMM and RfcommSocket interface)

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
