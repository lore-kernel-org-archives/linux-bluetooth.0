Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Chiverton <thomas.chiverton@bluefinger.com>
To: Chakravarthi Lalith-A5259C <A5259C@motorola.com>
Subject: Re: [Bluez-users] Time out!!
References: <2F8E7538CA01D711BC5900B0D079E7100394F3D0@zin03exm01.corp.mot.com>
In-Reply-To: <2F8E7538CA01D711BC5900B0D079E7100394F3D0@zin03exm01.corp.mot.com>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402251144.54833.thomas.chiverton@bluefinger.com>
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
Date: Wed, 25 Feb 2004 11:44:54 +0000

On Wednesday 25 Feb 2004 11:10 am, you said:
> beginner and would appreciate any step-by-step approach towards
> establishing a two-way connection with a motorola V-600 phone

Install blueZ.
Load the bluez modules 
*edit modules.conf
	alias net-pf-31 bluez
	alias bt-proto-0 l2cap
	alias bt-proto-2 sco
	alias tty-ldisc-15 hci_uart
*insmod rfcomm
hciconfig should show your adapter.
hciconfig hci0 up should bring it online.

Install kde-bluetooth.
*edit /etc/bluetooth/hcid.conf
	security user;
        pairing multi;
	pin_helper /usr/bin/kbluepin;
*reboot
*check hciconfig again
*start KDE - you should see a notification.
*init a normal pairing from you phone (see manual) - kde should prompt you for 
the PIN.

enter 'scp:/' as the URL in Konqueror - you should be able to browse onto your 
phone, obexpush, and it'll open the push client.

If you send files from the phone, a window should apper.

This is all based on my recent experience getting everything working with 
KDE3.2, on a RedHat9 box.


-- 
Tom Chiverton 
Advanced ColdFusion Programmer

Tel: +44(0)1749 834997
email: tom.chiverton@bluefinger.com
BlueFinger Limited
Underwood Business Park
Wookey Hole Road, WELLS. BA5 1AF
Tel: +44 (0)1749 834900
Fax: +44 (0)1749 834901
web: www.bluefinger.com
Company Reg No: 4209395 Registered Office: 2 Temple Back East, Temple
Quay, BRISTOL. BS1 6EG.
*** This E-mail contains confidential information for the addressee
only. If you are not the intended recipient, please notify us
immediately. You should not use, disclose, distribute or copy this
communication if received in error. No binding contract will result from
this e-mail until such time as a written document is signed on behalf of
the company. BlueFinger Limited cannot accept responsibility for the
completeness or accuracy of this message as it has been transmitted over
public networks.***


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
