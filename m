Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jason Bell <jaseb@enigmastation.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Belkin CF card (F8T020)
Message-ID: <20040123171347.A11107@enigmastation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 23 Jan 2004 17:13:47 -0500

Marcel,
Sorry it's taken a little while to get back to you.

modprobe lists the following of use.

alias net-pf-31 bluez
alias bt-proto-0 l2cap
alias bt-proto-2 scp
alias bt-proto-3 rcomm
alias bt-proto-4bnep
alias tty-ldisc-15 hci_uart
alias char-major-10-250 hci_vhc1

So as far as I can see it looks like it has loaded okay.

The Zaurus powers down on its own accord now, I think the card is sapping power as it's fine in the cradle.

Any help would be great.

Regards
Jase Bell



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
