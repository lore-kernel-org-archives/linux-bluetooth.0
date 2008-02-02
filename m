Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201961965.2389.358.camel@cookie.hadess.net>
References: <1201926335.15090.32.camel@violet>
	<1201957427.2389.354.camel@cookie.hadess.net>
	<1201958323.15090.36.camel@violet>
	<1201961965.2389.358.camel@cookie.hadess.net>
Date: Sat, 02 Feb 2008 16:07:26 +0100
Message-Id: <1201964846.15090.44.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce]
	Release	of	bluez-libs-3.25	and	bluez-utils-3.25
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

Hi Bastien,

> > > > this is an update release of the new stable versions of the Bluetooth
> > > > library and the utilities. This release updates the audio service with
> > > > experimental MPEG12/MP3 support. It also updates the GStreamer plugins
> > > > to make use of it.
> > > 
> > > I got a build problem with the 3.25 release of bluez-libs:
> > > sdp.c: In function 'sdp_data_alloc_with_length':
> > > sdp.c:450: error: 'USHRT_MAX' undeclared (first use in this function)
> > > sdp.c:450: error: (Each undeclared identifier is reported only once
> > > sdp.c:450: error: for each function it appears in.)
> > > sdp.c: In function 'sdp_append_to_buf':
> > > sdp.c:2393: error: 'UCHAR_MAX' undeclared (first use in this function)
> > > make[2]: *** [sdp.lo] Error 1
> > > 
> > > The attached patch fixes it for me, although I don't see the problem on
> > > my older system (Fedora 8 vs. Rawhide).
> > 
> > I hate when glibc changes its behavior. This code hasn't been touched
> > for over 3 years ;)
> > 
> > Anyway. Patch has been applied. Thanks.
> 
> I have no idea why they changed that. Same problem with a few defines in
> bluez-utils (missing UCHAR_MAX, USHRT_MAX and UINT_MAX).

patch has been committed to the CVS. Thanks.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
