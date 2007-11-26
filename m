Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5c1c70820711261359j2005400dy636f083260f08fee@mail.gmail.com>
Date: Tue, 27 Nov 2007 08:29:27 +1030
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196059088.4217.92.camel@aeonflux>
MIME-Version: 1.0
References: <5c1c70820711152155s3557856aja583f4c02a6f1d71@mail.gmail.com>
	<1196059088.4217.92.camel@aeonflux>
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

On 26/11/2007, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> > I'm trying to write an application using BlueZ which will:
> > - advertise a service, based on SPP (custom UUID, etc)
> > - listen for incoming connections for that service
> > - when an inbound connection is requested, create the connection
> > - send data to/from on the connection
>
> simply use the RFCOMM socket interface and use D-Bus only for
> registering the SDP record.

Thanks for your help.  I'm now using this approach and it is working well.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
