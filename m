Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] more bluepin
From: Marcel Holtmann <marcel@holtmann.org>
To: Gene Imes <ebi7@ozob.net>
Cc: list bluez <bluez-users@lists.sf.net>
In-Reply-To: <1087081230.21739.7.camel@tr1a.ozob.net>
References: <1087081230.21739.7.camel@tr1a.ozob.net>
Content-Type: text/plain
Message-Id: <1087228976.13792.19.camel@pegasus>
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
Date: Mon, 14 Jun 2004 18:02:56 +0200

Hi Gene,

> When I try to send a file from a windows box to my linux a dialog box
> appears on the windows box and the pairing is rejected by the linux box.
> 
> In the log:
> 
> Jun 12 15:25:29 [hcid] pin_code_request (sba=08:00:46:CC:91:76,
> dba=00:0D:88:C0:3E:DB)_
> Jun 12 15:25:29 [hcid] PIN helper exited abnormally with code 256
> 
> This may be related to my previous post.

if you got problems with the old PIN helper stuff, try the new D-Bus
enabled PIN helper.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
