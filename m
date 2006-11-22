Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Wed, 22 Nov 2006 11:13:59 +0530
Message-ID: <010701c70df9$35ee3590$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1164094036.28429.1.camel@localhost>
Subject: Re: [Bluez-users] L2CAP disconnect problem
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

Marcel,
So you mean if I use 2.6 kernel this problem will not occur. I tried
2.6.9-34.EL kernel but the same problem occurs. No RFCOMM disconnect :( 

Regds,
Sumeet 


-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Tuesday, November 21, 2006 12:57 PM
To: BlueZ users
Subject: Re: [Bluez-users] L2CAP disconnect problem

Hi Sumeet,

> I am using 2.4-20.8 with bluez-utils-2.25

actually this kernel is kinda old. You are better of with the latest 2.6
based kernel.

> I also tried using shutdown(fd, SHUT_RDWR) instead of close(fd) but 
> still the rfcomm doesn't disconnect. This happens only when I get an 
> incoming RFCOMM connection. When I initiate a connection, and disconnect,
it works.

This was a reference counting bug and I fixed it some time ago.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT Join SourceForge.net's
Techsay panel and you'll get the chance to share your opinions on IT &
business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
