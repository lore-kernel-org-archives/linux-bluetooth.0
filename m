Return-Path: <cyrus@holtmann.org>
Message-ID: <47E248FF.60402@infitsrl.com>
Date: Thu, 20 Mar 2008 12:22:39 +0100
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <1e720e88bd7ce5a74be321703f24060d@i61813>
	<A6B7F17C-B7E5-4A45-8208-D9C1FBC68C96@holtmann.org>
In-Reply-To: <A6B7F17C-B7E5-4A45-8208-D9C1FBC68C96@holtmann.org>
Subject: [Bluez-devel] RFCOMM sockets
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

Hi all,
I have 3 embedded devices with temperature sensor. This devices are 
accessed from a pc with linux reading data with rfcomm socket, isn't 
need to make sdp query for channel because rfcomm channels are 
statically assigned (it's lab equipment).

I need to read the 3 devices almost at same time and I've done a little 
C application using GLib IOChannels and non-blocking socket to read
data from the devices. All works fine but if a device it's off the 
connection to the others it's slow, my impression is it waits timeout 
from the first device.
I can understand why if I have 3 rfcomm connections issued in 
non-blocking way these influences each other.

I'm using BlueZ 3.22 on a debian 4.0 whith kernel version 2.6.22

Thanks

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
