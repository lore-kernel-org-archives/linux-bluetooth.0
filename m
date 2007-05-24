Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDCEBNCAAA.leiyu@kcoe.cn>
References: <EJENLMBEOLKAMCJFBFMDCEBNCAAA.leiyu@kcoe.cn>
Date: Thu, 24 May 2007 12:07:39 +0200
Message-Id: <1180001259.26519.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] how to cross-compile bluez
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

Hi Leiyu,

> I want to port Bluez to S3C2410 platform, the linux kernel of S3C2410 is 2.4.18,
> My PC linux kernel is 2.4.22,How may I go on cross-compile? Should I re-compile PC Linux kernel to 2.4.18 first?
>  
> Bluez kernel is embedded in Linux kernel, but may I get Bluez kernel from website ?  

use a 2.6 kernel. We don't support any 2.4 kernel anymore. Even if it is
extra effort to make a 2.6.21 kernel work, it is worth it, because this
make any other changes a lot easier.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
