Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44BAB94E.9060905@szift.org>
References: <44BAB94E.9060905@szift.org>
Date: Mon, 17 Jul 2006 00:20:51 +0200
Message-Id: <1153088451.19520.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BD hardware address problem
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

Hi Lukasz,

> I've been trying to make a bluetooth link between two computers, a 
> windows run laptop and my linux box - using two bluetooth usb dongles
> 
> The devices see each other (hcitool inq) but I can't get them connected 
> using pand:
> Jul 16 18:55:20 szift pand[5200]: Connecting to 11:11:11:11:11:11
> Jul 16 18:55:20 szift pand[5200]: Connect to 11:11:11:11:11:11 failed. 
> No route to host(113)
> 
> I think the problem is quite obvious: they both have been assigned the 
> same bd address: 11:11:11:11:11:11
> whatever I try, both devices still have the same bd addresses leading 
> even to a situation like this (when connected to the same PC):

this is a known problem and it is these stupid ISSC dongles where the
manufacturer doesn't assigned unique addresses to each dongle. You can
try to use bdaddr from CVS to set your own address.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
