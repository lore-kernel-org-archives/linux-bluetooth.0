Return-Path: <cyrus@holtmann.org>
Message-ID: <48D8048D.7080904@powercraft.nl>
Date: Mon, 22 Sep 2008 22:48:13 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------000104000200070806080803"
Subject: [Bluez-devel] key agent for bluez cli only
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000104000200070806080803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody,

I am looking for a solution to sent a key when a device is requesting
this. I hope somebody can help me out, I have attached a log file, that
also include some found issues.

pin_code_request (sba=00:1B:DC:00:32:71, dba=00:0D:FD:18:6E:3C)
connect(): Permission denied (13)
discovery failed

ps. attachment include

Best regards,

Jelle



--------------000104000200070806080803
Content-Type: text/x-log;
 name="bluez.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez.log"

Sep 22 22:38:57 debian-eeepc hidd[1908]: Exit
Sep 22 22:38:57 debian-eeepc hcid[1899]: Unregister path: /org/bluez/hci0
Sep 22 22:38:57 debian-eeepc hcid[1899]: Unregistered manager path
Sep 22 22:38:57 debian-eeepc hcid[1899]: Stopping SDP server
Sep 22 22:38:57 debian-eeepc hcid[1899]: Exit
Sep 22 22:38:58 debian-eeepc hcid[2432]: Bluetooth HCI daemon
Sep 22 22:38:58 debian-eeepc hcid[2432]: Parsing /etc/bluetooth/main.conf failed: No such file or directory
Sep 22 22:38:58 debian-eeepc hcid[2432]: Starting SDP server
Sep 22 22:38:58 debian-eeepc hcid[2432]: Unix socket created: 11
Sep 22 22:38:58 debian-eeepc hidd[2434]: Bluetooth HID daemon
Sep 22 22:38:58 debian-eeepc hcid[2432]: Registered manager path:/org/bluez/audio
Sep 22 22:38:58 debian-eeepc hcid[2432]: Loading device 00:0D:FD:18:6E:3C (headset sink control )
Sep 22 22:38:58 debian-eeepc hcid[2432]: Loading device 00:0C:55:D1:C9:78 (sink control )
Sep 22 22:38:58 debian-eeepc hcid[2432]: Setting 00:0C:55:D1:C9:78 as default device
Sep 22 22:38:58 debian-eeepc hcid[2432]: HCI dev 0 registered
Sep 22 22:38:58 debian-eeepc hcid[2432]: HCI dev 0 already up
Sep 22 22:38:58 debian-eeepc hcid[2432]: Device hci0 has been added
Sep 22 22:38:58 debian-eeepc hcid[2432]: Starting security manager 0
Sep 22 22:38:58 debian-eeepc hcid[2432]: Device hci0 has been activated
Sep 22 22:39:34 debian-eeepc hcid[2432]: Audio API: received BT_GETCAPABILITIES_REQ
Sep 22 22:39:38 debian-eeepc hcid[2432]: pin_code_request (sba=00:1B:DC:00:32:71, dba=00:0D:FD:18:6E:3C)
Sep 22 22:39:38 debian-eeepc hcid[2432]: connect(): Permission denied (13)
Sep 22 22:39:38 debian-eeepc hcid[2432]: discovery failed
Sep 22 22:39:38 debian-eeepc hcid[2432]: Audio API: sending BT_GETCAPABILITIES_RSP
Sep 22 22:39:39 debian-eeepc hcid[2432]: Audio API: received BT_GETCAPABILITIES_REQ
Sep 22 22:39:43 debian-eeepc hcid[2432]: pin_code_request (sba=00:1B:DC:00:32:71, dba=00:0D:FD:18:6E:3C)
Sep 22 22:39:43 debian-eeepc hcid[2432]: connect(): Permission denied (13)
Sep 22 22:39:43 debian-eeepc hcid[2432]: discovery failed
Sep 22 22:39:43 debian-eeepc hcid[2432]: Audio API: sending BT_GETCAPABILITIES_RSP
Sep 22 22:39:50 debian-eeepc hcid[2432]: Audio API: received BT_GETCAPABILITIES_REQ
Sep 22 22:39:53 debian-eeepc hcid[2432]: pin_code_request (sba=00:1B:DC:00:32:71, dba=00:0D:FD:18:6E:3C)
Sep 22 22:39:53 debian-eeepc hcid[2432]: connect(): Permission denied (13)
Sep 22 22:39:53 debian-eeepc hcid[2432]: discovery failed

sudo python /home/user/.simple-agent.py
ERROR:dbus.connection:Unable to set arguments ('/test/agent',) according to signature u'os': <type 'exceptions.TypeError'>: More items found in D-Bus signature than in Python arguments
Traceback (most recent call last):
  File "/home/jelle/.simple-agent.py", line 54, in <module>
    adapter.RegisterAgent(path)
  File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/var/lib/python-support/python2.5/dbus/connection.py", line 612, in call_blocking
    message.append(signature=signature, *args)
TypeError: More items found in D-Bus signature than in Python arguments

sudo /usr/share/doc/bluez-utils/examples/passkey-agent 0000 00:0D:FD:18:6E:3C
Can't register passkey agent
Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.

Sep 22 22:42:07 debian-eeepc hcid[2432]: register_passkey_agent called without any adapter info!
Sep 22 22:42:38 debian-eeepc last message repeated 242381 times
Sep 22 22:43:39 debian-eeepc last message repeated 459396 times
Sep 22 22:44:40 debian-eeepc last message repeated 477043 times

ps aux | grep hcid (high cpu load need to sudo killall -9 hcid)
root      2432 18.8  0.3   3452  1640 ?        Rs   22:38   0:57 /usr/sbin/hcid -x -s

--------------000104000200070806080803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------000104000200070806080803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000104000200070806080803--
