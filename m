Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm correction
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4100FD64.4080904@india.hp.com>
References: <loom.20040523T164826-243@post.gmane.org>
	 <1085324502.8309.19.camel@pegasus>
	 <loom.20040523T170840-699@post.gmane.org>
	 <1085326200.8309.22.camel@pegasus>  <4100FD64.4080904@india.hp.com>
Content-Type: text/plain
Message-Id: <1090585128.4791.45.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 23 Jul 2004 14:18:49 +0200

Hi Swarup,

> When I start rctest -s on lx1 without starting rctest -r on lx2, lx2 hangs
> and I have to switch it off and on to restart. This happens EVERY TIME
> I try this.  (In the previous mail, I had messed up the -r and -s)

as I said before, we need to know what kernel you are using and if
possible, what's the output of "hcidump -x" as root.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
