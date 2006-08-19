Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 00:53:30 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060819235330.GA16375@srcf.ucam.org>
References: <20060817100604.GA3350@srcf.ucam.org>
	<1155819858.4075.134.camel@aeonflux.holtmann.net>
	<20060817114116.GC5118@srcf.ucam.org>
	<20060817115912.GA24906@localhost.localdomain>
	<20060819143608.GA31812@srcf.ucam.org>
	<1156037973.3989.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1156037973.3989.14.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] [PATCH] implement RFCOMM Connect
	and	Disconnect	methods
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

On Sun, Aug 20, 2006 at 03:39:33AM +0200, Marcel Holtmann wrote:

> thanks for the patch, but what is the problem with sticking to Connect
> and CancelConnect and use their service string to identify UUID, handle
> or service name bases connections.

I'm not quite clear on what you mean here. The service string seems 
unacceptable because it requires bluez to have a table of every possible 
service and UUID in existence. Or are we talking about different things? 
Right now, the API gives us the following things that potentially 
identify an object:

1) The identifiers returned by GetIdentifiers (currently an arbitrary 
but unique integer, despite dbus-api.txt claiming it returns strings)
2) The UUID
3) The service handle
4) The ascii service string

My implementation provides connect methods for (2), (3) and (4). You 
didn't seem too happy about my patch providing support for (1), so I've 
dropped it :) Or do you just mean that there should be a single method 
and it should work out which piece of information has been passed by the 
app? In that case, I didn't implement it that way because determining 
the type was a bit of a pain and struck me as potentially fragile.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
