Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200405101448.i4AEmIK26418@home.iis.com.br>
From: <paulo@mail.wollny.com.br>
To: "=?ISO-8859-1?Q?=42=6c=75=65=5a=20=4d=61=69=6c=69=6e=67=20=4c=69=73=74?="<bluez-users@lists.sourceforge.net>
Reply-To: <paulo@mail.wollny.com.br>
Content-Type: text/plain;
Subject: [Bluez-users] Problem with Suse 9.0 and BlueZ
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
Date: Mon, 10 May 2004 11:48:19 -0300

Hi all,

i'm trying to use BlueZ with Suse 9.0 and am finding following problems:

1 - /dev/rfcomm0 could not be found.  I have tryed mknod /dev/rfcomm0 c 216 0. Is this right?

2 - Starting the daemons, it get the following message on /var/log/messages

 May 10 11:35:07 hirscheberg hcid[15820]: HCI daemon ver 2.3 started
May 10 11:35:07 hirscheberg hcid[15820]: Starting security manager 0
May 10 11:35:07 hirscheberg sdpd[15825]: SDPd ver 1.2 started
May 10 11:35:18 hirscheberg hcid[15820]: pin_code_request (sba=72:8C:01:72:02:00, dba=E2:59:22:E3:01:00)
May 10 11:35:18 hirscheberg kernel: Warning: null TTY for (d8:00) in tty_fasync
May 10 11:37:32 hirscheberg hcid[15820]: pin_code_request (sba=72:8C:01:72:02:00, dba=E2:59:22:E3:01:00)
May 10 11:37:32 hirscheberg kernel: Warning: null TTY for (d8:00) in tty_fasync

3 - When trying to contact the phone (a Siemens S55), after havin /etc/bluetooth/pin PIN:1234 with echo "ATZ" > /dev/rfcomm0 i can not connect to th phone.

Any help is welcome. 

Best regards,

Paulo Wollny






-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
