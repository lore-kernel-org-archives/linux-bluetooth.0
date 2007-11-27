Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474BC3EC.30106@omepet.es>
Date: Tue, 27 Nov 2007 08:14:52 +0100
From: jm <jmtoro@omepet.es>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>
In-Reply-To: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>
Subject: Re: [Bluez-devel] (no subject)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabrizio,

I think connection attempts (pscan procedure) are serialized by the dongle, =

so maybe you should do the sdp queries sequentially and create the thread
when the connection is ready. You can also try to reduce the page timeout =

with "hciconfig pageto" to discard soon devices not in range at connection
time.

Someone please correct me if I'm wrong.

Jos=E9 Miguel


> Hi all,
> I made a simple software to send small pictures to all bluetooth  =

> devices in range (it's used by a museum ).
> This software is made in C using bluez api, I've used two bluetooth  =

> dongles : one to make periodic inquiry (not with HCI periodic inquiry  =

> command by with a loop) and the other to make sdp query looking for  =

> obex push service and sending image.
> My requirement was to use this software in some embedded linux based  =

> computer so I chose to limit external library, I made all using  =

> pthread so there is an infinite thread for inquiries and one thread  =

> to handle every sdp query and relative connection when devices are  =

> discovered. I've discarded also using python or other scripting  =

> languages for the platfom limitations.
>
> All works but I found it not so efficient, also with 6/7 devices it's  =

> really slow to identify and connect to devices, some times connection  =

> are unexpectedly closed and so on....
>
> Is it my approch to the problem wrong or bluetooth protocol is not  =

> suitable for this type of use?
>
> I'm using libs version 3.7-1 (on debian 4.0)
>
> Many thanks
> Fabrizio
>   =

>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   =



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
