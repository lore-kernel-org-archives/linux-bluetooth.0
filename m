Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] ciptool setuid
Message-ID: <20040429223528.GA26563@gmx.net>
References: <200404292230.08106.ach@mpe.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404292230.08106.ach@mpe.mpg.de>
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
Date: Fri, 30 Apr 2004 00:35:28 +0200

On  0, Achim Bohnet <ach@mpe.mpg.de> wrote:
> In debian members of group dip and dialout and use modem/isdn devices.
> Unfortunately it looks like that one need to be root to run ciptool
> and make the isdn controler via bluetooth available.
> 
> Question: Are there other methods to enable members of group dialout
> to use ciptool that making it setuid root?  If not is it safe to
> install ciptool by default like
> 
> -rwsr-x---    1 root     dialout      8368 2004-01-26 23:22 /usr/bin/ciptool

Using sudo is the preferable way from security point of view.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
