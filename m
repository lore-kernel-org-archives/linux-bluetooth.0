Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fredrik Wendt <fredrik@wendt.se>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 20 Sep 2007 11:59:23 +0200
Message-Id: <1190282363.24745.46.camel@desktop3>
Mime-Version: 1.0
Subject: [Bluez-devel] gstreamer + bluetooth-alsa (a2dp) = stalls after song
	switch
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

Hi all. 


My first post, I'm not capable of C programming but believe I can assist
with basic error searching (gdb is out of my scope, strace and ltrace I
understand, more or less :)

My issue is that if I use rhythmbox or banshee that both use gstreamer
they get stalled/hang after changing to a new song. It basically just
hangs and a2dpd says something about client error. (Other clients
continue to work.)

xmms only behaves like this when I manually restart playing the same
track again (hit the play button while the song is playing). To me, it
looks like the way gstreamer connects to alsa needs attention? Or is it
alsasink that has issues talking to the a2dpd device?

How should I proceed to find out where things go wrong? 

What do you want me to report if noone has reported this (sounds
unlikely to me, but google didn't give me much help otoh) to be of help
to you?

* Ubunty Feisty (latest/up-to-date kernel and packages from Ubuntu
distribution)
* a2dpd built from CVS
(http://bluetooth-alsa.sourceforge.net/build.html), got it at 2007-09-11
06:15 CET.


Thanks in advance,

	Fredrik Wendt


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
