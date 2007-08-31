Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46D8419E.9050604@andorsystems.com>
Date: Fri, 31 Aug 2007 18:28:14 +0200
From: giulio fedel <giulio.fedel@andorsystems.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <79be12f70708301153s7c6961e3jda270e4fe394d1ca@mail.gmail.com>
In-Reply-To: <79be12f70708301153s7c6961e3jda270e4fe394d1ca@mail.gmail.com>
Subject: Re: [Bluez-users] BlueZ Hcid and D-Bus On ARM
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Yes,
I'm working on an arm platform (at91rm9200) and it works.
kernel 2.6.22
dbus 1.0.2
bluez 3.14
It is important that dbus and hcid use the same file location for the 
socket:
[--prefix=]/var/run/dbus/system_bus_socket
where --prefix is /usr/local by default or something you specified 
during configure phase.
dbus-daemon read it from etc/dbus-1/system.conf <listen>...</listen> line,
it not clear to me where hcid read it or if it uses only the default.
use hcid -n option (and the strace utility) to understand something more...

     Giulio


John Sample wrote:
> Has anyone here gotten hcid to connect to D-Bus on an embedded ARM 
> system?  I can get the dbus system daemon up an running, but everytime I 
> start hcid it dies right away and I get a "couldn't connect to D-Bus" 
> message in my syslog.  I don't know what else to even try - any 
> suggestions?
> 
> -- 
> John Sample
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
