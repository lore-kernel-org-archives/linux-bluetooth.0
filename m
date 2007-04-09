Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sf.net>
Date: Mon, 9 Apr 2007 16:56:09 +0530
Message-ID: <008d01c77a99$df6baff0$8935c70a@dlh.st.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] hcidump-1.34 startup problem
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

 Hi 
I found the solution to this problem . hcidump was taking the libraries from /lib/libbluet....
My library was installed in /usr/local/lib. I copied the libbluetooth library to /lib and it worked.

Regards,
Sumeet 
-----Original Message-----
From: sumeet verma [mailto:sumeet.verma@st.com] 
Sent: Monday, April 02, 2007 5:00 PM
To: bluez-users@lists.sf.net
Subject: hcidump-1.34 startup problem

Hi
I am using bluez-hcidump-1.34.
Its installed properly but when I try to run it , it gives and error

[root@dlhl0330 3.9]# hcidump -X -V
hcidump: error while loading shared libraries: libbluetooth.so.2: cannot open shared object file. No such file or directory [root@dlhl0330 3.9]#

libluetooth.so.2->libbluetooth.so.2.5.0 in /usr/local/lib

Regards,

Sumeet 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
