Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sco mtu: 64: 0
References: <43CBA230.6080403@pagestation.com> <1137428636.6324.61.camel@localhost.localdomain> <43CBCC65.3040403@pagestation.com>
In-Reply-To: <43CBCC65.3040403@pagestation.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601161745.44889.cijoml@volny.cz>
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
Date: Mon, 16 Jan 2006 17:45:44 +0100

Hi,

Try better lsusb -vvv

Michal

Dne po 16. ledna 2006 17:40 Jerry Geis napsal(a):
> Marcel,
>
> Thanks, here it is
>
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 002: ID 047d:105e Kensington
> Bus 001 Device 001: ID 0000:0000
>
> If you have something you want me to try I'd be happy
> to try it...
>
> Jerry
>
> Marcel Holtmann wrote:
> >Hi Jerry,
> >
> >first of all, please use standard plain text ASCII emails in this
> >mailing list. I don't need extra big fonts and prefer to choose the size
> >of my fonts by myself and not by a weird HTML email.
> >
> >>I saw that an SCO MTU: 16:0 should work for audio.
> >>What about an SCO MTU: 64: 0 - will that work?
> >
> >At the moment I am collection information about the Broadcom dongles and
> >how to integrate a quirk for them. Please include the output of lsusb
> >for this device.
> >
> >Regards
> >
> >Marcel
> >
> >
> >
> >
> >-------------------------------------------------------
> >This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> > files for problems?  Stop!  Download the new AJAX search engine that
> > makes searching your log files as easy as surfing the  web.  DOWNLOAD
> > SPLUNK! http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
S pozdravem

Michal Semler


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
