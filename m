Return-Path: <cyrus@holtmann.org>
Message-Id: <C232EB85-B614-4396-9537-9DCE8F2C8F55@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <462043.24837.qm@web8401.mail.in.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Tue, 29 Jan 2008 16:11:48 +0200
References: <462043.24837.qm@web8401.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied
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


On Jan 29, 2008, at 16:08, pramod gurav wrote:
> I am able to connect now...
> but the connection lasts for only for few seconds..after it gets  
> disconnected,.
> Also the pop up is not comming on the system...it came only once...

If you take a look at your hcid log you'll see that there are plenty  
of "permission denied" errors. Probably you're trying to run hcid as  
something else than root and it fails because of that (and a properly  
running hcid is essential for bluetooth functionality).

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
