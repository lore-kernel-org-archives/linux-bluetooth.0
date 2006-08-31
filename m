Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F6B7AE.1030209@jambit.com>
Date: Thu, 31 Aug 2006 12:19:26 +0200
From: Frank Heimbaecher <frank.heimbaecher@jambit.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Play received A2DP data
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear community

I have a bit of experience with Bluetooth, but almost none with Audio
streaming. Maybe somebody could give me some useful hints, URLs or
HowTos to help me to get on.

My programming task: Receive audio stream from A2DP, decode it and play
it. Reception of A2DP stream is ok for me, decoding should work with
sbc, but there is still the problem how to get the data to the sound
card. So far I thought I need a sound driver for A2DP, as a kernel
module and call open, ioctl and write via snd_hwdep routines. Is that right?

Thanks for help
Frank

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
