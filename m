Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474C16C7.6040704@aircable.net>
Date: Tue, 27 Nov 2007 10:08:23 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>	<1196151954.17196.15.camel@aeonflux>
	<474BF69A.3030008@infitsrl.com>
In-Reply-To: <474BF69A.3030008@infitsrl.com>
Subject: Re: [Bluez-devel] Scan and push images
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fabrizio,
> I'd like to accept Your suggests but:
> - If I use periodic inquiry I need obligatory dbus to  receive callback 
> events?
> - How can I perform pre-filter on remote devices that support object 
> transfer if I've not discovered their servies?
>   
Check this project: http://code.google.com/p/proximitymarketing/ the
idea was to make an open source proximity marketing solution. Check in
the svn there's a proximity scanner (it uses dbus to scan for devices,
and does name resolving under requests, you need to change the functions
callbacks). It uses dbus bindings, and it's written in C.

I will make the official announcement for the project as soon as I
finish with my examns.

Cheers,
Manuel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
