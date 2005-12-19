Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219130355.209.qmail@web36103.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134996357.31688.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 19 Dec 2005 05:03:55 -0800 (PST)

Hello Marcel,
As a root if i type in hcid. It doesn't give any
error. This means hcid is running. I am unable to find
syslog under /var/log directory. I am running Fedora
core 4. Some of the syslog listed by sylog are as
below. Can you pls  help to find which syslog file i
am supposed to check.

====================================
/etc/logrotate.d/syslog
/etc/syslog.conf
/etc/sysconfig/syslog
/etc/rc.d/init.d/syslog
/usr/lib/perl5/5.8.6/syslog.pl
/usr/lib/perl5/5.8.6/i386-linux-thread-multi/syslog.ph
/usr/lib/perl5/5.8.6/i386-linux-thread-multi/sys/syslog.ph
/root/install.log.syslog
/var/lock/subsys/syslog
/var/log/anaconda.syslog
====================================

Warm Regards,
Swathi


--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Swathi,
> 
> > How to i make sure hcid is running ?
> 
> this depends on your distribution, but you can also
> start by hand as
> root.
> 
> > And which syslog
> > should i check ie the path of syslog ?
> 
> It is /var/log/syslog as on almost every Unix
> operating system.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
