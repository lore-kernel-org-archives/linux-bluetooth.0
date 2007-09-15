Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 15 Sep 2007 11:14:25 +0200
From: Charles =?iso-8859-1?Q?Cl=E9ment?= <caratorn@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070915091425.GA22095@tux>
MIME-Version: 1.0
Subject: [Bluez-devel]  Audio service configuration file
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

Hello all,

The 3.18 version of bluez-utils didn't install the audio.conf file, so
when I started the service, here's the output of dmesg :

audio[22077]: Parsing /etc/bluetooth/audio.conf failed: No such file or
directory

Shouldn't this file be installed by default if audio is enabled in the
configuration?

Thanks,

-- =

Charles Cl=E9ment.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
