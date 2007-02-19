Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <986121.73512.qm@web31703.mail.mud.yahoo.com>
References: <986121.73512.qm@web31703.mail.mud.yahoo.com>
Date: Mon, 19 Feb 2007 18:56:51 +0100
Message-Id: <1171907811.26567.32.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] mouse wont connect...
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

Hi Tim,

> ok i ran sudo hidd --server and it tells me 
> Can't listen on HID control channel: Address already
> in use
> 
> i assume that means its already running.
> 
> but now im getting a different hcidump, looks like its
> connecting but then something is terminating the
> connection...

you need a successful hidd --search first, because otherwise the HID
server will reject any connections. This is a security measurement. You
can check with /sys/class/bluetooth/l2cap if the PSM 17 and 19 are in
use before starting hidd --server and the place to automatically start
that daemon is /etc/default/bluetooth if you use Debian or Ubuntu.

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
