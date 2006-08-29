Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 29 Aug 2006 11:06:13 +0200
From: The Peach <smartart@tiscali.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060829110613.49f2a9a4@localhost>
In-Reply-To: <20060822181532.6fea4851@localhost>
References: <20060822181532.6fea4851@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] rfcomm hell
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

On Tue, 22 Aug 2006 18:15:32 +0200
The Peach <smartart@tiscali.it> wrote:

> Objective: connect to the mobile (a nokia 6680) and to the GPS reciver

I found what was wrong, and it was udev.
After following a tutorial I added the following rule to change the permissions upon dev creation:

# cat /etc/udev/rules.d/10-udev.rules 
KERNEL="rfcomm[0-9]*", NAME="bluetooth/%k", GROUP="users", MODE="0660"

after commenting it rfcomm started connecting :-D

thanks for the help :)

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
