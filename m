Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <464194a50705140636m31a90100gbd8111982012d7de@mail.gmail.com>
References: <464194a50705140636m31a90100gbd8111982012d7de@mail.gmail.com>
Date: Mon, 14 May 2007 16:22:58 +0200
Message-Id: <1179152578.13351.47.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Combination Keys?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> I'm doing my bachelors dissertation project about alternative Bluetooth authentication and key exchange and I would like to know whether it is possible to pass the combination key my app has constructed to BlueZ in some way, so that BlueZ will write the key in /var/lib/bluetooth/<BD_ADDR>linkkeys or my application should tamper with the file directly. 

you might wanna modify the file directly or better use the textfile.c
library to do so.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
