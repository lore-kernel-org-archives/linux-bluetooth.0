Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jurgens du Toit" <dutoitjj@yahoo.co.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ipaq 1945
Message-Id: <20040928112643.M59598@modiredi.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Sep 2004 13:28:51 +0200

Is ip forwarding turned on?

cat /proc/sys/net/ipv4/ip_forward
if this returns zero, it's turned off

echo "1" > /proc/sys/net/ipv4/ip_forward
to turn it on

Jrgns

--
Sent by Jurgens du Toit (083-511-7932)
Hosted by Modiredi (http://www.modiredi.co.za)
Powered By Bizmail (http://www.bizmail.co.za)


-- 
This message has been scanned for viruses and
dangerous content by MailScanner.

Modiredi Internet Services cc
postmaster@modiredi.co.za



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
