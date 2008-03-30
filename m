Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <47EFEB1E.7010903@inescn.pt>
From: filipe abrantes <fla@inescporto.pt>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, filipe_abrantes@netcabo.pt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] hcitool scan gives timeout on an ipaq 5500
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
Date: Sun, 30 Mar 2008 20:33:50 +0100

hello list:

ive been using bluez on an ipaq, but im having some problems:

how i set up bt on ipaq:

# uname -r
2.4.19-rmk6-pxa1-hh36
# pand
PAN daemon version 1.1rc2
..
# hcitool
hcitool - HCI Tool ver 2.2
# hcid --version
hcid: invalid option -- -
hcid - HCI daemon ver 2.3

#hciattach /dev/tts/1 any 921600
# hciconfig
hci0:   Type: UART
        BD Address: 08:00:17:1F:C5:E4 ACL MTU: 339:4  SCO MTU: 60:9
        UP RUNNING PSCAN ISCAN
        RX bytes:88 acl:0 sco:0 events:11 errors:1
        TX bytes:652 acl:0 sco:0 commands:25 errors:0

... and the hcid.conf files are similar on both the ipaq and my pc



when i try hcitool scan on ipaq:

# hcitool scan
Scanning ...
Inquiry failed.: Connection timed out

when i try on my pc:

# hcitool scan
Scanning ...
        08:00:17:1F:C5:E4       ipaq

then when i put my pc on: pand --listen --role GN
...and try to connect: pand --connect 00:10:60:A4:89:15 (on the ipaq side)

it doesn t establish connection.

but on the other end if i try  to switch roles, the pc can connect to 
the ipaq  (the ipaq is now GN)  then it works out ok.


any ideas on whats happening?


thanks all


filipe


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
