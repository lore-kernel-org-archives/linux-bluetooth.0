Return-Path: <cyrus@holtmann.org>
Message-ID: <a2c6daca0801252048w1be1f0b4q58d4ce0f806017b8@mail.gmail.com>
Date: Fri, 25 Jan 2008 22:48:23 -0600
From: troxlinux <xserverlinux@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] passkey Vs Pin_helper
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

hello list, recently a cellular Nokia E65 buys me which want to
connect to my laptop for bluetooth, I have installed centos 5 with the
packages :

bluez-utils-3.7-2.el5.centos
bluez-libs-3.7-1
bluez-gnome-0.5-5.fc6
bluez-hcidump-1.32-1



I have configured the hcid.conf in 2 ways and with any it works me, he
requests me the password every 6 second and it doesn't accept it

options {
autoinit yes;
security auto;
pairing multi;
passkey "1234";
}

device {
name "MY PHONEC";
class 0x000100;
iscan enable; pscan enable;
lm accept;
lp rswitch,hold,sniff,park;
}

log :

Unknown option 'pin_helper' line 5
Jan 23 22:11:23 xserver hcid[22723]: syntax error line 5
Jan 23 22:11:23 xserver hcid[22723]: Register path:/org/bluez fallback:1



options {
autoinit yes;
security auto;
pairing multi;
passkey "1234";
}

device {
name "MY PHONEC";
class 0x000100;
iscan enable; pscan enable;
lm accept;
lp rswitch,hold,sniff,park;
}

log:

 xserver hcid[28509]: Bluetooth HCI daemon
Jan 24 17:47:10 xserver hcid[28509]: Register path:/org/bluez fallback:1
Jan 24 17:47:10 xserver hcid[28509]: HCI dev 0 registered
Jan 24 17:47:10 xserver hcid[28509]: Register path:/org/bluez/hci0 fallback:0
Jan 24 17:47:10 xserver hcid[28509]: HCI dev 0 already up
Jan 24 17:47:10 xserver hcid[28509]: Device hci0 has been added
Jan 24 17:47:10 xserver hcid[28509]: Starting security manager 0
Jan 24 17:47:10 xserver sdpd[28515]: Bluetooth SDP daemon
Jan 24 17:47:10 xserver hcid[28509]: Device hci0 has been activated
Jan 24 17:48:41 xserver hcid[28509]: pin_code_request
(sba=00:0B:0D:0A:CA:5D, dba=00:1C:A4:9F:BA:98)



greetingsss

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
