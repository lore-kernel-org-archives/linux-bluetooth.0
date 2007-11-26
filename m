Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5c1c70820711152155s3557856aja583f4c02a6f1d71@mail.gmail.com>
References: <5c1c70820711152155s3557856aja583f4c02a6f1d71@mail.gmail.com>
Date: Mon, 26 Nov 2007 07:38:08 +0100
Message-Id: <1196059088.4217.92.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Serial server problems
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

Hi Pooyan,

> I'm trying to write an application using BlueZ which will:
> - advertise a service, based on SPP (custom UUID, etc)
> - listen for incoming connections for that service
> - when an inbound connection is requested, create the connection
> - send data to/from on the connection

simply use the RFCOMM socket interface and use D-Bus only for
registering the SDP record.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
