Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200706060847.21565.dennisveatch@bellsouth.net>
References: <200706060847.21565.dennisveatch@bellsouth.net>
Date: Wed, 06 Jun 2007 14:50:53 +0200
Message-Id: <1181134253.13429.150.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils-3.11 and configure
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

Hi Dennis,

> Um I might be totally out in left field here but there seems to be some 
> deficiencies with the build process in that all the files are not getting 
> installed during make install.
> 
> I have tried configure with --enable-all and specifying all the configure 
> switches individually with the same results. From what I can tell the 
> following files do not get installed from the source tree;
> 
> audio/asound.conf
> common/libhelper.a
> common/test_textfile
> daemon/auth-agent
> daemon/passkey-agent
> daemon/bluetoothd
> eglib/libeglib
> hcid/libhciserver.a
> hcid/service-did.xml
> hcid/service-ftp.xml
> hcid/service-opp.xml
> hcid/service-spp.xml
> sbc/sbcdec
> sbc/sbcenc
> sbc/sbcinfo
> sbc/libsbc.la
> sdpd/libsdpserver.a
> test/apitest
> test/attest
> test/bdaddr
> test/hsmicro
> test/hsplay
> test/hstest
> test/lmptest
> test/scotest
> test/sdptest
> tools/hcisecfilter
> tools/ppporc

all of these are _NOT_ installed on purpose. As simple as that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
