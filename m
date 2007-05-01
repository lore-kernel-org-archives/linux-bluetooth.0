Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sean <sean@mailcan.com>
To: Bluez-users <bluez-users@lists.sourceforge.net>
Date: Tue, 01 May 2007 14:46:20 -0700
Message-Id: <1178055980.6346.7.camel@bridgetek.localhost>
Mime-Version: 1.0
Subject: [Bluez-users] headsetd input distorted and high pitch
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

Hello,
  I recently compiled a new 2.6.20 kernel with the sco-flowcontrol-v4.1
patch and am attempting to get headsetd working correctly.   Using aplay
and arecord, I can play and record sound.  However the recorded sound is
very distorted and high pitched.  Playback is fine.  To double check
things, I compiled and installed btsco and the snd_bt_sco kernel module
and using this method the recorded sound is normal.  I would prefer to
use headsetd as btsco causes occasional kernel panics for me and also
like the fact that it is a userspace program.

  Can anyone provide some guidance in troubleshooting this?  

PS. I tried to search the mail archives, but sourceforge keeps timing
out :|

Thanks,
- Sean


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
