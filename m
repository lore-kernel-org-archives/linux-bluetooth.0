Return-Path: <cyrus@holtmann.org>
Message-ID: <488048F2.7070303@wurmsdobler.org>
Date: Fri, 18 Jul 2008 08:40:34 +0100
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] HCI commands for testing
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

Hello,

Our mx27 based system contains a APM6628 module which itself comprises a 
bluetooth and wifi part. In the context of testing the bluetooth part 
(built on a BC4-ROM), we would like to put it into a test mode using HCI 
commands, both the "Remote Loopback Mode" and the "Device Under Test 
Mode". From the specification I can see that there are hex codes defined 
for these commands (only OCF, 0x0002 and 0x0003, respectively). I would 
like to use hcitool on the host:

mx27# hcitool -i hci0 cmd 0x06 0x0003

Unfortunately, the BC4-ROM does not seem to recognise the command 
(perhaps the OGF) and hcidump tells me that the command is 'Unknown'. My 
question is now, what are the exact OCF and OGF values to be used with 
hcitool in order to to put the BC4-ROM into "Remote Loopback Mode" and 
"Device Under Test Mode"?

Many thanks for any hint,
peter


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
