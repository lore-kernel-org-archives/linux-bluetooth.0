Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcid pin problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Tetsuo Shiraishi <tetsu@s-direct.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4.3.2-J.20040613230727.0638bee8@emi.s-direct.com>
References: <4.3.2-J.20040613230727.0638bee8@emi.s-direct.com>
Content-Type: text/plain
Message-Id: <1087228825.13792.14.camel@pegasus>
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
Date: Mon, 14 Jun 2004 18:00:25 +0200

Hi Tetsuo,

> I could not get pin_helper to work, 
> since I upgraded to bluez-utils-2.7 from bluez-utils-2.3.
> 
> Using system
> - sh4-linux
> - patch-2.4.24-mh5.gz 
> - bluez-libs-2.7.tar.gz 
> - bluez-utils-2.7.tar.gz 
> - pin_helper in hcid.conf
> 
> I modified bluez-utils-2.7 as follows, so it work fine.
> 
> --- bluez-utils-2.7/hcid/security.c	Sun May  9 19:39:43 2004
> +++ bluez-utils-2.7_mod/hcid/security.c	Sun Jun 13 22:53:29 2004
> @@ -236,7 +236,7 @@
>  {
>  	pin_code_reply_cp pr;
>  	struct sigaction sa;
> -	char addr[12], str[255], *pin, name[20];
> +	char addr[18], str[255], *pin, name[20];
>  	FILE *pipe;
>  	int ret, len;

thanks for this report. I applied your patch.

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
