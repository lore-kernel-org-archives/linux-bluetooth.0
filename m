Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <50563.71.108.25.50.1172789534.squirrel@mail.corecoding.com>
Date: Thu, 1 Mar 2007 14:52:14 -0800 (PST)
From: "Chris Monahan" <chris@corecoding.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] BCM2045 loading issue
Reply-To: chris@corecoding.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Thanks to Timur, I got my BCM2045 working. But in order to get it to work,
I have to run hciconfig hci0 down and restart the bluetooth daemon
everytime. I'm not sure if this is a distrobution or driver problem, but
is there a way around this? Do I have to edit my /etc/bluetooth/ config
files?


-- 
Christopher Monahan
Chief Technology Officer
Core Coding (http://www.corecoding.com)
chris@corecoding.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
