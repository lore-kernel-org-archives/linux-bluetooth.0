Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050418141520.70316.qmail@web15501.mail.cnb.yahoo.com>
From: Zhixiang Deng <zhixiang_deng@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-users] Cannot create L2CAP socket
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 18 Apr 2005 22:15:20 +0800 (CST)

Hi all,when I tried to connect to the GN by typing the
command "pand --connect BTADDR",It failed .The
/var/log/message shows the following :

kernel: application bug: pand(5128) has SIGCHLD set to
SIG_IGN but calls wait().
kernel: (see the NOTES section of 'man 2 wait').
Workaround activated.
modprobe: modprobe: Can't locate module bt-proto-0
pand[5128]: Cannot create L2CAP socket. No such file
or directory(2)

I'm a beginner of bluez,I don't know why this happened
.What can I do to solve this problem ?
Thanks a lot !


_________________________________________________________
Do You Yahoo!?
注册世界一流品质的雅虎免费电邮
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
