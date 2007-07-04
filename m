Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <468B9427.4020401@gmail.com>
Date: Wed, 04 Jul 2007 09:35:51 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <EJENLMBEOLKAMCJFBFMDKECOCAAA.leiyu@kcoe.cn>
In-Reply-To: <EJENLMBEOLKAMCJFBFMDKECOCAAA.leiyu@kcoe.cn>
Subject: Re: [Bluez-users] how to receive file by bluetooth using embedded
 linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1527688421=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1527688421==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Leiyu,
Check out the openobex library and the obexftp app,
http://dev.zuckschwerdt.org/openobex/wiki/ObexDownloads, I had been
able, and I'm using this in an ARM processor running OpenSlug, with no GUI.
Gnome Bluetooth Tools, or Kde Bluetooth is useless for you, you don't
want to install neither the Gnome or the KDE lib.
Thanks,
Manuel
> Dear All,
>
> I use bluez in S3C2410 to drive the bluetooth dongle and insert a U disk in S3C2410 board for storing the received file
> In the other word, I use 2410 with bluetooth dongle , it receives file from PC by bluetooth and then stores it into U disk
> I do not have GUI , the system is not same as PC Linux, when receiving file,it does not need  to pop up a message for confirming ,
> I have installed bluez-lib,bluez-utils and so on, I can drive the dongle now, what should I do if I want to receive file by bluetooth?
> last time   Luiz Siqueira tell me that Try Gnome Bluetooth tools -> http://ubuntuforums.org/showthread.php?t=94713
> but I want to change bluez a littler to finish the function ,may I have any good way ?
> I appreciate for your help!
>
> by the way ,how to reply the email  in http://news.gmane.org/gmane.linux.bluez.user
>
>
> Best reagards,
> Leiyu
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   



--===============1527688421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1527688421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1527688421==--
