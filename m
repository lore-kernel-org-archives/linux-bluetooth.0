Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <036e01c78e29$bb1298f0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <016001c788a0$b7b229c0$8935c70a@dlh.st.com><200705031357.04459.denis.kenzior@trolltech.com><1178169928.6891.39.camel@violet>
	<200705041736.31072.denis.kenzior@trolltech.com>
Date: Fri, 4 May 2007 10:53:48 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] sdpd and multiple bluetooth devices
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hello,

I'm sorry I think this is a very simple question ...

I have 2 devices hci0 and hci1 and I'd like to manage
services on both with sdptool.

Could you please tell me how I should configure
/etc/rc.d/init.d/bluetooth
so I have 2 SDP databases, one for each device ?
... for now I just have "daemon sdpd" in this file

Then can I use sdptool -i hciN ... ?

Thanks a lot,
Oli

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
