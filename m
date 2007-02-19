Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070219095145.GA1828@perldition.org>
References: <20070219095145.GA1828@perldition.org>
Date: Mon, 19 Feb 2007 11:18:14 +0100
Message-Id: <1171880294.26567.9.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcidump segfault
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

Hi Florian,

> I'm trying to sync a Sony Ericsson W810i mobile using wammu over
> bluetooth. Scanning for the device works fine, but when trying to
> connect wammu hangs. I tried to debug that problem using hcidump and
> saw it segfaulting after telling wammu to connect. Therefor I think the
> problem is caused by something other than the wammu/gammu code or my
> local bluetooth configuration.

a segfault of hcidump means nothing. It is a stupid protocol analyzer
and fully passive. I am pretty sure that the wammu OBEX code is at fault
here.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
