Return-Path: <cyrus@holtmann.org>
Message-ID: <8ccc3510712161042v197dbef8i4a4a23a5c7fd0be4@mail.gmail.com>
Date: Sun, 16 Dec 2007 19:42:10 +0100
From: "Christophe-Marie Duquesne" <chm.duquesne@gmail.com>
To: "BlueZ development" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Can't listen on HID control channel: Address already
	in use
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0492944250=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0492944250==
Content-Type: multipart/alternative;
	boundary="----=_Part_1878_18033808.1197830530827"

------=_Part_1878_18033808.1197830530827
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody.

everytime I run

sudo hidd --server

I have this output.

I had no problem before, it started when I upgraded my ubuntu to the most
recent release. Some fedora
folks<http://forums.fedoraforum.org/showthread.php?t=156389>wrote it
was a matter of order of service startup and I had to make hidd
start before bluetooth. But there is no script named like "*hidd*" in my
/etc/init.d/ directory. Have you heard of this problem? Do you know how to
solve it? Thanks.

Christophe-Marie.

------=_Part_1878_18033808.1197830530827
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody.<br><br>everytime I run<br><br>sudo hidd --server<br><br>I have this output.<br><br>I had no problem before, it started when I upgraded my ubuntu to the most recent release. <a href="http://forums.fedoraforum.org/showthread.php?t=156389">
Some fedora folks</a> wrote it was a matter of order of service startup and I had to make hidd start before bluetooth. But there is no script named like &quot;*hidd*&quot; in my /etc/init.d/ directory. Have you heard of this problem? Do you know how to solve it? Thanks.
<br><br>Christophe-Marie.<br>

------=_Part_1878_18033808.1197830530827--


--===============0492944250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0492944250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0492944250==--
