Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: resource
	temporarily unavailable
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050128172646.695.qmail@web53205.mail.yahoo.com>
References: <20050128172646.695.qmail@web53205.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106939965.10580.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 28 Jan 2005 20:19:25 +0100

Hi Filipa,

> I am have Linux 2.6.9 in my laptop and an Conceptronic
> CBT 100U USB adapter. I installed bluez-utils-2.14 and
> bluez-libs-2.14.
> 
> 'hciconfig -a' shows me my device and 'hcitool scan'
> show me the computer of a friend (a windows pc). I can
> do an 'l2ping' and an 'rfcomm bind' to this computer
> without any problem. 
> 
> The problems arrive when I try to do 'rfcomm connect'.
> The answer is: "Can't connect RFCOMM socket: resource
> temporarily unavailable". 

you can't use bind and connect together. Choose one.

> I saw on the web and on the mailling lists that there
> is a problem with the 'bluepin'. I checked mine and it
> didn't work. So, I created a new file (called pin in 
> /usr/bin/) with:
> 
> #!bin/sh
> # file: /usr/bin/pin
> echo -n "PIN: "
> cat /etc/bluetooth/pin
> 
> and created a file in /etc/bluetooth/ also called pin
> with a numerical the PIN code.
> 
> Still I could not make the 'rfcomm connect' work! It
> appears a window asking for the PIN in my friend's
> computer, but in my computer I still have the same
> answer.

Check with "hcidump -x" as root if it is really a PIN helper problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
