Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4655449F.2080000@movilok.com>
Date: Thu, 24 May 2007 09:54:07 +0200
From: "J. Carlos Alvarez" <jcalvar@movilok.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Concurrent hcitool commands
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, we are trying to use hcitool to retrieve some information about =

several devices and we need to do it in parallel (several scripts =

concurrently call "hcitool name XX:XX:XX:XX:XX" using the same local =

device looking for the name of several remote devices).

Doing this we found that some responses received from different remote =

devices were mixed, we obtained the same device name from two different =

remote devices.

The following is a simple way to check this behaviour:
---------------------------------------------------------------
[root@localhost~]# hcitool -i hci0 name 00:12:D1:DB:9A:E3
Nokia E70
[root@localhost~]# hcitool -i hci0 name 00:13:FD:FC:DE:50
Nokia 6680
[root@localhost~]# hcitool -i hci0 name 00:12:D1:DB:9A:E3 & hcitool -i =

hci0 name 00:13:FD:FC:DE:50
[1] 14223
Nokia E70
Nokia E70
[1]+  Done                    hcitool -i hci0 name 00:12:D1:DB:9A:E3
---------------------------------------------------------------

- The first command gets the right name of our E70 phone:
 "Nokia E70"

- The second one also gets the right name of our 6680 phone:
 "Nokia 6680"

- But if we invoke both commands concurrently, both "hcitool" calls get =

the same name as the device response:
 "Nokia E70"
 "Nokia E70"

Are we doing something wrong?

Is there any technical limitation related to this kind of requests so we =

must to do these calls serially?

Is this a bug?

Thanks in advance,

Juan Carlos

-- =

Juan Carlos Alvarez                               jcalvar@movilok.com
---------------------------------------------------------------------
MOVILOK Interactividad M=F3vil                   http://www.movilok.com
Isaac Newton, 1                                  tlf: +34 918.046.105
Parque Tecnol=F3gico de Madrid
28760 Tres Cantos - Madrid
---------------------------------------------------------------------
      "Computers are useless. They can only give you answers."
                                         (Pablo Ruiz Picasso)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
