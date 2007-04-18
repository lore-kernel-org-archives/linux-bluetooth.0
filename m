Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4625B4FC.9000006@tlau.org>
Date: Tue, 17 Apr 2007 23:04:44 -0700
From: Tessa Lau <tlau@tlau.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] "Can't get conn info" error pairing Treo with
	Bluetooth dongle
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

I'm running Ubuntu Edgy.  I'm trying to pair a Treo 700p with the Linux 
box via a USB Bluetooth dongle:

    Bus 004 Device 011: ID 1131:1001 Integrated System Solution Corp. 
KY-BT100 Bluetooth Adapter

Linux seems to recognize the Bluetooth adapter.  Hciconfig reports it as 
device hci0:

hci0:   Type: USB
        BD Address: 00:11:67:4F:E7:FF ACL MTU: 678:8 SCO MTU: 64:10
        UP RUNNING PSCAN ISCAN
        RX bytes:2934 acl:0 sco:0 events:180 errors:0
        TX bytes:2041 acl:0 sco:0 commands:99 errors:0

In /etc/bluetooth/hcid.conf, I have the following settings:

options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "XXXXX";
}

When I initiate pairing from the Treo, it prompts me for a PIN and then 
immediately says that it's unable to add my computer to the trusted 
security list.  I see the following error in my daemon.log:

Apr 17 22:41:23 localhost hcid[4203]: Device hci0 has been activated
Apr 17 22:41:42 localhost hcid[4203]: pin_code_request 
(sba=00:11:67:4F:E7:FF, dba=00:07:E0:B9:8A:4A)
Apr 17 22:41:42 localhost hcid[4203]: Can't get conn info: No such file 
or directory (2)

 From looking at the code in hcid/security.c:358, it looks like this 
error occurs when the ioctl call returns ENOENT (No such file or 
directory).  What does this mean?  What file or directory is it looking 
for?  What else can I try to triage this problem?

Thanks in advance,
--Tessa

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
