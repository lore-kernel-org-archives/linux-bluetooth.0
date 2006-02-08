Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43EA3E0D.5030005@gmail.com>
From: nix4me@gmail.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] bluez and dbus
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
Date: Wed, 08 Feb 2006 11:53:01 -0700

Hello,
To start off, I am trying to use bluez on a slackware 10.2, 2.6.15 
system. I've managed to pair my system
with a microsoft keyboard, and my motorolla v551 phone. My plantronics 
m2500 is another story.

To successfully connect to the phone, and the keyboard, I have to not 
use authentication. hcid refuses to
start, giving the following error in my syslog: Failed to connect to 
socket /var/run/dbus/system_bus_socket: No
such file or directory.

I have tried using dbus-0.23 through .60. Bluez-libs, and utils, 2.21, 
2.24, 2.25, both slack packages and
compiling them myself. I'm assuming this has nothing to do with bluez, 
but dbus?

I have been at this for week's, someone please help.

Best regards
Doug


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
