Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <00e401c43867$ee3193f0$80c8fea9@Perigee.Perigeellc.com>
From: "Rob Taft" <rtaft@sensis.com>
To: <bluez-users@lists.sourceforge.net>
References: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com> <200405122103.08265.cijoml@volny.cz> <00ac01c4385e$f6aed230$80c8fea9@Perigee.Perigeellc.com> <200405122257.01637.pavouk@pavouk.org>
Subject: Re: [Bluez-users] DHCPD and Bluetooth
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
Date: Wed, 12 May 2004 17:27:24 -0400

I think I'm almost there.
I noticed that it is not HW based after I posted.  I saw in
/var/log/messages a message that occurred ever connection:

May 12 17:01:20 SMED /etc/hotplug/net.agent: invoke ifup bnep0

So I went into the net.agent file and found this line that matched the
output:

debug_mesg invoke ifup $INTERFACE

I added more lines to that so now it looks like this:

if [ -x /sbin/ifup ]; then
    debug_mesg invoke ifup $INTERFACE
    debug_mesg LALALALALALALALALALA #ADDED THIS
    exec /sbin/ifup $INTERFACE
    debug_message Attempting to restart dhcpd.    #ADDED THIS
    exec /etc/init.d/dhcpd restart  #ADDED THIS
else
     mesg "how do I bring interfaces up on this distro?"
fi

I then restarted my entire system....and the 2nd 2 lines were never reached.
I added the LALALA line after and that appears in the logs...so I'm guessing
that "exec /sbin/ifup $INTERFACE" is causing the script to exit





----- Original Message ----- 
From: "Pavel Ruzicka" <pavouk@pavouk.org>
To: <bluez-users@lists.sourceforge.net>
Cc: "Rob Taft" <rtaft@sensis.com>
Sent: Wednesday, May 12, 2004 4:57 PM
Subject: Re: [Bluez-users] DHCPD and Bluetooth


> Hello,
>
> > restart it.  I don't think hotplug is what I am looking for since it is
> > hardware connection based.
>
> This is not only hardware connection based. When you try setup network
from
> remote device, that kernel call /sbin/hotplug with NET action.
> You can edit script "/etc/hotplug.d/default/default.hotplug" or other in
your
> distribution and uncomment line "DEBUG=yes export DEBUG".
> Later you can look in to log file for interesting messages ;-)
> In this case will be probably interesting script /etc/hotplug/net.agent.
>
> Best regards,
>
> Pavel Ruzicka
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to
deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
