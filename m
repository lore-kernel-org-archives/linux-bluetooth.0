Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 26 Mar 2007 11:41:38 +0300 (EEST)
From: Martin Fluch <fluch@rock.helsinki.fi>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0703261141240.2782@localhost.localdomain>
MIME-Version: 1.0
Subject: [Bluez-users] Nokia Headset BH-900?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi!

Does anyone have success with connecting to the Nokia Headset BH-900?

I'm running I quite recent Debian system (unstable) and have no problems to 
connect to my phone via bluez/hcitool/hkbluetoothd etc. But I am unable to get 
a connection to my headset.

seneca:~# hcitool scan
Scanning ...
         00:13:70:3E:CA:09       Nokia BH-900

...which is my headset.

seneca:~# hcitool cc 00:13:70:3E:CA:09 ; hcitool auth 00:13:70:3E:CA:09

...which then makes KBluetoothD pop up with a pin request window. But even 
before I manage to enter the pin "0000" there I get in the syslog the following 
messages:

Mar 26 11:23:34 localhost hcid[4962]: link_key_request (sba=00:80:98:34:65:1D, 
dba=00:13:70:3E:CA:09)
Mar 26 11:23:34 localhost hcid[4962]: pin_code_request (sba=00:80:98:34:65:1D, 
dba=00:13:70:3E:CA:09)
Mar 26 11:23:34 localhost hcid[4962]: Calling PasskeyAgent.Request: name=:1.7, 
path=/org/bluez/passkey_agent_4989
Mar 26 11:23:36 localhost hcid[4962]: PasskeyAgent.Request(/org/bluez/hci0, 
00:13:70:3E:CA:09) was canceled

:-/

And then after some waiting hcitool aborts with the message:

    HCI authentication request failed: Connection timed out

:-/

My /etc/bluetooth/hcid.conf file looks like:

options {
 	autoinit yes;
 	security auto;
 	pairing multi;
 	passkey "0000";
}
device {
 	name "Seneca";
 	class 0x7e0100;
 	iscan enable; pscan enable;
 	lm accept;
 	lp rswitch,hold,sniff,park;
}

And the info obtained from hcitools about the headset is:

seneca:~# hcitool info 00:13:70:3E:CA:09
Requesting information ...
         BD Address:  00:13:70:3E:CA:09
         Device Name: Nokia BH-900
         LMP Version: 2.0 (0x3) LMP Subversion: 0xa5b
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x8b 0xf8 0x18 0x18 0x00 0x80
                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                 <transparent SCO> <broadcast encrypt> <enhanced iscan>
                 <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                 <extended SCO> <AFH cap. slave> <AFH class. slave>
                 <AFH cap. master> <AFH class. master> <extended features>

I use hcitool ver 3.7 and a plain but self compiled Linux 2.6.20.3 kernel. And 
as said before, connecting to my Nokia 6131 works wonderfull.

I tried to google for some information about the usage of the  Nokia HB-900 
under linux and bluze but didn't find any results on the web. :-/

Any ideas?
- Martin


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
