Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problems connecting to Nokia 6310I phone.
References: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
In-Reply-To: <Pine.LNX.4.58.0405302214280.8012@sebagqbbe.gwsvfure.pb.hx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405311453.05771.tim@birdsnest.maths.tcd.ie>
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
Date: Mon, 31 May 2004 14:53:04 +0100

On Sunday 30 May 2004 22:25, Toby Fisher wrote:

> Thanks in advance for any pointers you can offer.

Here's a log of mine connecting to GPRS through a Nokia 6310 -
don't know if it's any use.

Script started on Mon 31 May 2004 14:35:59 IST
[tim@martha tim]$ su
Password:=20
[root@martha tim]# # Bluetooth switched on on laptop and phone
[root@martha tim]# service bluetooth restart
Shutting down Bluetooth: =1B[60G[  =1B[0;32mOK=1B[0;39m  ]=1B
[60G[  =1B[0;32mOK=1B[0;39m  ]=0D
Starting Bluetooth: =1B[60G[  =1B[0;32mOK=1B[0;39m  ]=1B[60G[  =1B[0;32mOK=
=1B[0;39m  ]=0D
[root@martha tim]# rfcomm bind 0 $PHONE 1
[root@martha tim]# rfcomm -a
rfcomm0: 00:02:EE:10:A5:BE channel 1 clean=20
[root@martha tim]# pppd debug call O2
[root@martha tim]# # ctrl-C
[root@martha tim]# tail -30 /var/log/messages
May 31 14:37:44 martha chat[4014]: send (ATD*99#^M^J^M)
May 31 14:37:44 martha chat[4014]: expect (CONNECT)
May 31 14:37:44 martha chat[4014]: ^M
May 31 14:37:44 martha chat[4014]: ^M
May 31 14:37:44 martha chat[4014]: OK^M
May 31 14:38:14 martha chat[4014]: alarm
May 31 14:38:14 martha chat[4014]: send (ATD*99#^M^J^M)
May 31 14:38:15 martha chat[4014]: expect (CONNECT)
May 31 14:38:15 martha chat[4014]: ^M
May 31 14:38:15 martha chat[4014]: CONNECT
May 31 14:38:15 martha chat[4014]:  -- got it=20
May 31 14:38:15 martha chat[4014]: send (^M)
May 31 14:38:15 martha pppd[4006]: Serial connection established.
May 31 14:38:15 martha pppd[4006]: Using interface ppp0
May 31 14:38:15 martha pppd[4006]: Connect: ppp0 <--> /dev/rfcomm0
May 31 14:38:18 martha pppd[4006]: PAP authentication succeeded
May 31 14:38:18 martha pppd[4006]: kernel does not support PPP filtering
May 31 14:38:20 martha pppd[4006]: not replacing existing default route to=
=20
eth0 [192.168.3.1]
May 31 14:38:20 martha pppd[4006]: local  IP address 62.40.51.4
May 31 14:38:20 martha pppd[4006]: remote IP address 10.6.6.6
May 31 14:38:20 martha pppd[4006]: primary   DNS address 62.40.32.33
May 31 14:38:20 martha pppd[4006]: secondary DNS address 62.40.32.34
May 31 14:38:33 martha pppd[4006]: Terminating on signal 2.
May 31 14:38:34 martha pppd[4006]: Connection terminated.
May 31 14:38:34 martha pppd[4006]: Connect time 0.3 minutes.
May 31 14:38:34 martha pppd[4006]: Sent 82 bytes, received 64 bytes.
May 31 14:38:34 martha pppd[4006]: Connect time 0.3 minutes.
May 31 14:38:34 martha pppd[4006]: Sent 82 bytes, received 64 bytes.
May 31 14:38:34 martha pppd[4006]: Exit.
[root@martha tim]# exit
exit
[tim@martha tim]$ exit
Script done on Mon 31 May 2004 14:41:28 IST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /etc/ppp/peers/O2 =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
rfcomm0 115200 crtscts
connect '/usr/sbin/chat -v -f /etc/ppp/O2.chat'
debug
modem
lock
receive-all
nodetach
noipdefault
defaultroute
user gprs
password gprs
usepeerdns
nobsdcomp
nodeflate
logfile "/home/tim/ppp.log"
noauth
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /etc/ppp/O2.chat =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
TIMEOUT		5
ABORT		'\nBUSY\r'
ABORT		'\nERROR\r'
ABORT		'\nNO ANSWER\r'
ABORT		'\nNO CARRIER\r'
ABORT		'\nNO DIALTONE\r'
ABORT		'\nRINGING\r\n\r\nRINGING\r'
''		\rAT
TIMEOUT		30
OK		ATH
# OK		ATE1
OK		ATE0
OK		ATV1
OK		'AT+CGDCONT=3D1,"IP","open.internet","",0,0'
OK		'ATD*99#\r\n'
CONNECT-ATD*99#\r\n-CONNECT		""
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=2D-=20
Timothy Murphy =20
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
