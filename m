Return-Path: <cyrus@holtmann.org>
From: Colin Murphy <lists@spudulike.me.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 1 Jan 2008 21:09:19 +0000
MIME-Version: 1.0
Message-Id: <200801012109.19744.lists@spudulike.me.uk>
Subject: [Bluez-users] Stereo audio headset - half a second of audio,
	8 seconds of silence, then disconnection.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have XMMS set up to play alsa audio through bluetooth.  This is what happens 
when I try to play some audio.  

On hitting the 'play' button there is a 2 second delay before XMMS begins to 
play, and the Graphic EQ bars start to dance.  Half a second, or so, of audio 
can be heard from the headphones, after which they go silent, even though the 
Graphic EQ bars continue to dance for another 8 seconds.  After the bars have 
stopped dancing I get a message that the bluetooth connection has been 
dropped. 

There's another glimpse from my /var/log/syslog file hiding at 
http://pastebin.ubuntu.com/3181/

Is this an alsa or bluetooth problem?   Because the GEq bars continue to dance 
it makes me think something must be getting through to XMMS, but it might 
also be considered correct for the bluetooth connection to be dropped 
automatically after 8 seconds of silence, I don't know.  I also don't know 
how to find the solution.  Any help much appreciated, especially advice on 
where else, log files, etc, to look.

-- 
Colin@spudulike.me.uk
Gotta' go, things to be, people to do, stuff to, err, stuff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
