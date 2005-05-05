Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4279AAE1.40500@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] gumstix+infineon can't scan/connect
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 04 May 2005 23:10:57 -0600

Hi

I think there must be some defaults/settings that aren't right on this 
gumstix (using infineon hardware). Can anyone see any reason the basics 
won't work?

  hcitool scan

returns immediately with no results; when run on the desktop, it finds 
the headset without any problems.

  sdptool browse  00:0D:44:2A:5C:A3

fails with "Failed to connect to SDP server on 00:0D:44:2A:5C:A3: 
Connection refused" but again it works on the desktop.

finally, a2play fails to connect (I have it ignore the sdp problem)

  a2play 00:0D:44:2A:5C:A3 /mnt/mmc/charm.au

reports "Can't connect to A3:5C:2A:44:0D:00. Connection refused(111)
cannot open psm_cmd = 25" so it fails in the connect call:

  connect(sk, (struct sockaddr *) &addr, sizeof(addr))

Here's how things look...

# grep -v ^$ /etc/bluetooth/hcid.conf |grep -v ^.*#
options {
         autoinit yes;
         security auto;
         pairing multi;
         pin_helper /etc/bluetooth/bluepin;
}
device {
         name "Gumstix (%d)";
         class 0x820116;
         iscan enable; pscan enable;
         lm accept;
         lp rswitch,hold,sniff,park;
}
# /etc/bluetooth/bluepin
PIN:0000
# hciconfig
hci0:   Type: UART
         BD Address: 00:80:37:21:61:42 ACL MTU: 672:8 SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:30107175 acl:59964 sco:0 events:19745 errors:0
         TX bytes:1959214 acl:19657 sco:0 commands:38 errors:0

# hciconfig hci0 revision
hci0:   Type: UART
         BD Address: 00:80:37:21:61:42 ACL MTU: 672:8 SCO MTU: 64:0

  Generated: Nov 28 2003 16:59:35
  Comment: R2D

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
