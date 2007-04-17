Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Reiner Klenk <pdq808@t-online.de>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 17 Apr 2007 22:26:03 +0200
Message-Id: <1176841564.31230.14.camel@grappa>
Mime-Version: 1.0
Subject: [Bluez-devel] plugz on N800
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
somewhat to my surprise plugz and sbc compile without problems in
scratchbox. I copied libs and the a2dpd binary to the Nokia N800 and
they appear to work reasonably well with mplayer. CPU load due to a2dpd
is about 20%, so there are enough cycles left for mp3/ogg decoding
without the DSP. It probably won't be easy to convince the build-in apps
to output via a2dpd. Nevertheless, this means I now have bluetooth
stereo on my N800! 

Thanks,
Reiner
 
-- 
debb1046 (gmail.com, gtalk, jabber.org, ekiga.net, last.fm, skype)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
