Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9307f5f20610200432m7e1fc647q977c82598d765460@mail.gmail.com>
Date: Fri, 20 Oct 2006 13:32:06 +0200
From: "P. Durante" <shackan@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1161340912.27585.53.camel@localhost>
MIME-Version: 1.0
References: <200610191334.25362.denis.kenzior@trolltech.com>
	<1161249153.27710.5.camel@localhost>
	<9307f5f20610200330s5f867c41h2dc0096c6d4e5458@mail.gmail.com>
	<1161340912.27585.53.camel@localhost>
Subject: Re: [Bluez-devel] SDP over XML
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

Hi Marcel,
>
> you only need D-Bus for hcid and not sdptool.
>
I didn't read denis' patches, but I was thinking the plan was to make
sdptool use the new sdp D-Bus api (when it's settled down), this way
you could avoid the code duplication which is now going on between
hcid and sdptool
>
> And D-Bus has support for two different XML parsers.
>
you have a point, I was remembering libxml2 support was broken but
can't find anything to substantiate that tought right now

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
