Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Philippe Berini <philippe@berini.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051025163115.GA29385@loulou-becane>
References: <20051020135234.GC28731@loulou-becane> <20051023123808.GA14322@elmicha.333200002251-0001.dialin.t-online.de> <20051023151215.GB31746@loulou-becane> <1130191981.9463.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1130191981.9463.13.camel@localhost.localdomain>
Subject: [Bluez-users] Re: Re: Buetooth and SAMSUNG SGH-E340
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 25 Oct 2005 18:31:15 +0200

* Fredy P <digitalfredy@debiancolombia.org> [Mon, Oct 24, 2005 at 05:12:59PM -0500]:

> El dom, 23-10-2005 a las 17:12 +0200, Philippe Berini escribió:
> umm now think to i know what is your prloblem, you can't paring the
> devices because the pin helper by default is for X, for fix the problem
> you need change the /usr/local/bin/bluez-localpin, see [1], again is in
> spanish but you can read the config files and comands.
> [1] http://el-directorio.org/index.php/Bluetooth_en_debian

I can read Spanish, no problem about that :-) 

I can pair my devices, the mobile says it is paired. Obexftp still
complains it can't connect (following the instructions given on both the
web sites).

# obexftp -b 00:12:47:AB:AF:46 -B 7 -l
Browsing 00:12:47:AB:AF:46 ...
Channel: 7
No custom transport
Connecting...bt: -1
failed: connect


I am wondering if the problem does not lie there:

# /etc/init.d/bluez-utils restart
Restarting bluez-utils: hcid sdpdsyntax error line 25
 rfcomm.

and the line 25 is as follows:

vi /etc/init.d/bluez-utils
[snip] 
SDPD=/usr/sbin/sdpd

I can't see a syntax error...

-- 
Philippe Berini                


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
