Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sunnan <sunnan@handgranat.org>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1137558415.7455.20.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Apple mouse gives me various "Can't get device information"
 troubles
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
Date: Wed, 18 Jan 2006 05:26:54 +0100

Hi, everyone,
I'm trying to pair my Apple wireless mouse on my Ubuntu 5.10 iBook with
built in bt; it's been out of use for a while and now nothing works
(maybe some packages messed up or something; the hidd daemon doesn't
start by default anymore, for one). I'm still using bluez-utils 2.20,
hope that's fine.

If I understand correctly, hidd --connect is used for pairing and only
has to be done once (unless it resets somehow), right? Well, it resetted
somehow and now I try to --connect it again.

Whenever I try to do:
hidd --connect 00:0A:95:01:5F:57
I get either
Can't get device information: Host is down
or (slightly more often, but this seems random)
Can't get device information: Permission denied
if the mouse is on, and
Can't get device information: File descriptor in bad state
if the mouse is off.

(When my builtin bt (00:0D:93:04:19:15) is in hid-mode instead of hci, I
get 
Can't get device information: No route to host
but I figure that's "more" wrong so I've been doing most of my testing
with it in hci-mode.)

I've been trying to troubleshoot this for a couple of hours; originally
"bluepin" was crashing so I just replaced it with a small shell script
that echoed "PIN:1234" (got the number from my /etc/bluetooth/pin file,
don't know if that's the number the mouse wants: how do I set it?) which
got rid of the "PIN helper exited abnormally with code 256" issues in
in /var/log/daemon.log

Advice is appreciated,
Sunnan




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
