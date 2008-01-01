Return-Path: <cyrus@holtmann.org>
From: Colin Murphy <lists@spudulike.me.uk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 1 Jan 2008 20:20:08 +0000
MIME-Version: 1.0
Message-Id: <200801012020.08991.lists@spudulike.me.uk>
Subject: [Bluez-users] Understanding /etc/bluetooth/audio.conf
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

I am fighting to get a  workable link between stereo headsets and a USB 
dongel.  My current set-up has been configured with the Blueman gui. When I 
go to play some audio from XMMS which is set up for Bluetooth, I can see that 
a connection is made, I get half a second of audio and 8 seconds of silence, 
after which the connection is dropped.  This is on my Ubuntu 7.10 system.

There is much I don't understand about this subject and I will need to chip 
away at the problems a piece at a time.

My first query is with audio.conf.  I can see the following 
in /var/log/syslog :-

Jan  1 19:34:09 colin-desktop hcid[29890]: Bluetooth HCI daemon
Jan  1 19:34:09 colin-desktop hcid[29890]: HCI dev 0 registered
Jan  1 19:34:09 colin-desktop hcid[29890]: HCI dev 0 already up
Jan  1 19:34:09 colin-desktop hcid[29890]: Device hci0 has been added
Jan  1 19:34:09 colin-desktop hcid[29890]: Starting security manager 0
Jan  1 19:34:09 colin-desktop hcid[29890]: Device hci0 has been activated
Jan  1 19:34:09 colin-desktop hcid[29890]: Starting SDP server
Jan  1 19:34:09 colin-desktop hcid[29890]: Created local server at 
unix:abstract=/var/run/dbus-3kjjteaAME,guid=d6d35f0826ae92b0ea7f9100477a95b1
Jan  1 19:34:09 colin-desktop audio[29898]: Bluetooth Audio daemon
Jan  1 19:34:09 colin-desktop audio[29898]: /etc/bluetooth/audio.conf: Key 
file does not have key 'SCORouting'
Jan  1 19:34:09 colin-desktop audio[29898]: /etc/bluetooth/audio.conf: Key 
file does not have key 'Enable'
Jan  1 19:34:09 colin-desktop audio[29898]: /etc/bluetooth/audio.conf: Key 
file does not have key 'Disable'
Jan  1 19:34:09 colin-desktop audio[29898]: /etc/bluetooth/audio.conf: Key 
file does not have group 'A2DP'
Jan  1 19:34:09 colin-desktop audio[29898]: Config options: DisableHFP=true, 
SCORouting=HCI, SourceCount=1
Jan  1 19:34:09 colin-desktop audio[29898]: Unix socket created: 5

The entries 'Key file does not have *' bother me, they look like error 
messages.  The audio.conf file has not been edited by me by hand, though my 
tinkering may have upset something.  

Do these lines look suspicious?  Since I don't understand what they are I need 
to ask your advice on the current config options, do they look correct?



-- 
Colin@spudulike.me.uk
Gotta' go, things to be, people to do, stuff to, err, stuff.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
