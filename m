Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DHCPD and Bluetooth
Cc: "Rob Taft" <rtaft@sensis.com>
References: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com> <200405122103.08265.cijoml@volny.cz> <00ac01c4385e$f6aed230$80c8fea9@Perigee.Perigeellc.com>
In-Reply-To: <00ac01c4385e$f6aed230$80c8fea9@Perigee.Perigeellc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405122257.01637.pavouk@pavouk.org>
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
Date: Wed, 12 May 2004 22:57:01 +0200

Hello,

> restart it.  I don't think hotplug is what I am looking for since it is
> hardware connection based.

This is not only hardware connection based. When you try setup network from
remote device, that kernel call /sbin/hotplug with NET action.
You can edit script "/etc/hotplug.d/default/default.hotplug" or other in your 
distribution and uncomment line "DEBUG=yes export DEBUG".
Later you can look in to log file for interesting messages ;-)
In this case will be probably interesting script /etc/hotplug/net.agent.

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
