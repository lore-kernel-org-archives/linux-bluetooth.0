Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: "Jackie" <xhx321@gmail.com>
Date: Sun, 20 Apr 2008 23:02:08 +0800
Message-ID: <fufltc$fre$1@ger.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] What's wrong with the l2ping during the
	cross-compling!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0772769005=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0772769005==
Content-Type: text/plain; format=flowed; charset="gb2312"; reply-type=original
Content-Transfer-Encoding: 7bit

Dears:
I meet such question which delayed my schedule for several days.
The issue is that : I compiled the blueZ-2.20 in X86 platform, and execute 
the command like "l2ping xx:xx:xx:xx", it can worked well.
but after compiled it with mipsel-compiler,and run the same command in 
mipsel platform, the shell tips "Connection failed: invalid arguments". And 
in the mipsel platform, the "hcitool scan" could work well already.but 
'l2ping' & 'sdptool browse' can work which both tips "invalid argument". And 
I have execute the hcidump in mipsel, which show only two lines. One is the 
outgoing command data , the other is feedback events data. Compared it with 
the result that hcidump in X86, the first outgoning command data is same. 
But, the feedback data which has four bytes, the first byte is different 
which seems like statue code, the other three bytes is same.
Almost forget that: In x86 the linux kernel version is 2.6.10, while in 
mipsel kernel version is 2.4.21(I've done the newest patch).
If anybody met the same thing or knew what the reason, please give me some 
help!
 




--===============0772769005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0772769005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0772769005==--
