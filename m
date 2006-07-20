Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BF9824.5060904@xmission.com>
Date: Thu, 20 Jul 2006 08:50:12 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <000201c6abdd$702e4340$9b01a8c0@LiYong>
In-Reply-To: <000201c6abdd$702e4340$9b01a8c0@LiYong>
Subject: Re: [Bluez-users] Cannot use a2play on ARM Linux 2.6.16
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1502787319=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1502787319==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

YongLi wrote:
> Hello All,
> 
> I am porting the Linux 2.6.16 to ARM 9 CPU. 

make sure you build with fixed point:

./configure --enable-fixed && make clean all

also, you should try

a2play -p addr

this uses the rtc which is a bit dodgy on arm, but see how it works. we
should be using usleep()

brad


--===============1502787319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1502787319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1502787319==--
