Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8712867d0608231418ld76b304oc8ae4ba1d8269d56@mail.gmail.com>
References: <8712867d0608231353l6aa027bbha331a44392231f92@mail.gmail.com>
	<8712867d0608231418ld76b304oc8ae4ba1d8269d56@mail.gmail.com>
Date: Thu, 24 Aug 2006 11:01:29 +0200
Message-Id: <1156410090.4133.68.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Fwd: bluez-utils: The inquiry scan (ISCAN)
	gets	turned off
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

Hi Jaime,

> Whenever I try to discover the local system (Debian computer) from a remote
> system (mobile device, or other computer) it can't be found. After
> some research I found out that the ISCAN mode is disabled:

this should have been fixed in bluez-utils-3.3. You have to set the
discoverable timeout to 0 and the mode to "discoverable" over the new
D-Bus API and then it will stay visible forever. Otherwise it goes back
to being non-discoverable after the discoverable timeout.

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
