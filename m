Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 20 Nov 2007 14:30:57 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803A90D3E@esebe104.NOE.Nokia.com>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] bluez-utils/audio/pcm_bluetooth.c:
	drop-pcm_bluetooth-gettimeofday
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

Hello again,

here's a patch that gets rid of all uses of gettimeofday() 
and also does away with using struct timevals for calculating
the hw_ptr. Should have no impact to plugin functionality.

Patch available at:
http://sofia-sip.org/~vehmanek/bluez-patches/patch-20071120-kv-drop-pcm_
bluetooth-gettimeofday.txt

-- 
first.surname@nokia.com (Kai Vehmanen)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
