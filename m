Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030512132833.0d19d8a0@unixmail.qualcomm.com>
To: Krisztian Mark Szentes <office@produktivit.com>, bluez-users@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
In-Reply-To: <200305081542.17759.office@produktivit.com>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 May 2003 13:29:41 -0700

At 06:43 AM 5/8/2003, Krisztian Mark Szentes wrote:
>May  8 15:02:20 tomcat cardmgr[1071]: socket 0: 3Com Bluetooth PC Card
>May  8 15:02:20 tomcat cardmgr[1071]: executing: 'modprobe bt3c_cs'
>May  8 15:02:21 tomcat hcid[1428]: HCI dev 0 registered
>May  8 15:02:31 tomcat hcid[1616]: Can't init device hci0. Connection timed out(110)
Hmm, you should see bluefw messages before HCI dev 0 registered.
I guess you'd need to ping Marcel on that one.

Max



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
