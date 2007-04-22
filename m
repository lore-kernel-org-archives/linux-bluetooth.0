Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 22 Apr 2007 10:52:11 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: bluez-devel@lists.sourceforge.net
Message-id: <7.0.1.0.2.20070422102711.03d6a030@dubai.oilfield.slb.com>
MIME-version: 1.0
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
 upgrade your Kernel !
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

Hi,

Apologies for jumping onto the end of this thread but I joined the 
mailing list a few days after the initial message.

 > ALSA lib pcm_sco.c:273:(sco_headset_hw_params) Unable to set number of
 > SCO buffers : please upgrade your Kernel !

I have exactly the same error on a machine using DSL-N (2.6.12) and a 
Sonyericsson HBH-610 Bluetooth headset - the same setup works fine 
with DSL (2.4.26) and bluezsco.

I can compile plugz without problems using:

cvs 
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa 
login
cvs 
-d:pserver:anonymous@bluetooth-alsa.cvs.sourceforge.net:/cvsroot/bluetooth-alsa 
co plugz
cd plugz
./bootstrap
./configure --prefix=/usr
make
sudo make install

But what cvs command is meant by "cvs update your plugz to head and 
it should work"?

Thanks
John


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
