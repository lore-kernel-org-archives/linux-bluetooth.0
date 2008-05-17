Return-Path: <cyrus@holtmann.org>
Message-Id: <2E70A86E-D0FD-4BBB-AF6F-815544489ED7@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <884634.96017.qm@web81308.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 17 May 2008 09:18:13 +0200
References: <884634.96017.qm@web81308.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Losing SCO connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Michael,

> It seems like some phones just don't like having a SCO connection up  
> when voice call is not in progress.  So instead of actively trying  
> to connect to the phone, I just let the phone connect to my SCO  
> listener socket as needed and I don't have the disconnect problem  
> anymore.  i.e. I just had to reverse the server/client direction in  
> my app.
> There's one remaining problem though.  Occasionally, I hear garbage  
> voice on the receive side of SCO.  hcidump shows maybe the 16-bit  
> samples are in wrong endianness.  This stays like that until the SCO  
> is closed and reestablished.  Anyone seen this problem?   I will try  
> out a CSR dongle also.

look through the mailing list archives. It can happen that everything  
is off by one. Either use 8 bit SCO or try to detect it.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
