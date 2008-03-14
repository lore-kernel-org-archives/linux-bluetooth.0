Return-Path: <cyrus@holtmann.org>
Message-ID: <47DA5229.3050605@aircable.net>
Date: Fri, 14 Mar 2008 08:23:37 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1205440348.12951.9.camel@californication>
In-Reply-To: <1205440348.12951.9.camel@californication>
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
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

Hello everyone,
> so we are near to the end-of-lifetime for the BlueZ 3.x series. We will
> have only a few release left and the plan is to end it with the magic
> number 3.33 in a few weeks.
>   
Nice :D, finally good work everyone.

> Most of the new API is already implemented and will be part of the 3.29
> release within the next few days. All new features are marked as
> experimental until we reach 4.0 and you have to start hcid with the -x
> option to enable them.
>   
Cool, will be an existing experience,

> Please review the interface APIs and do some early testing.
>   
I have a question regarding the APIs, in the past there was a way to
initiate scanning without name resolving, and I've been through all the
new API and couldn't find it. Is this going to be removed? I had found
it as a nice feature, specially when you are in a very crowded area and
you want to discover a device from which you know some stuff like the
bluetooth address beginning.

Cheers,
Manuel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
