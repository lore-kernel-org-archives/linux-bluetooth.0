Return-Path: <cyrus@holtmann.org>
Date: Sun, 02 Nov 2008 17:44:35 +0400
From: John Frankish <frankish@dubai.oilfield.slb.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-id: <0K9P00CTDKUICGC0@gb0135mbx01.mail.slb.com>
MIME-version: 1.0
Subject: Re: [Bluez-devel] Pairing with a Headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

At 15:36 12-10-08, you wrote:
>Hi,
>
>I'm using bluez-4.12/bluez-gnome-1.8 and tried out pairing my laptop
>with a SE HBH-610 headset
>
>A couple of questions:
>
>Q1 Using bluetooth-wizard, I got this.
>
>Connecting to null now...
>Please enter the following PIN code: 0000
>
>Since I could not enter anything on the headset, I waited 20-30s and
>then, as per bluetoothd -n, the pairing seemed to work:
>
>bluetoothd[6061]: Discovery session 0xb96d4098 with :1.1 activated
>bluetoothd[6061]: Discovery session 0xb96d4098 with :1.1 deactivated
>bluetoothd[6061]: link_key_request (sba=00:10:C6:56:F4:9F,
>dba=00:12:EE:A6:1D:F4)
>bluetoothd[6061]: pin_code_request (sba=00:10:C6:56:F4:9F,
>dba=00:12:EE:A6:1D:F4)
>bluetoothd[6061]: link_key_notify (sba=00:10:C6:56:F4:9F,
>dba=00:12:EE:A6:1D:F4)
>bluetoothd[6061]: Registered interface org.bluez.Headset on path
>/org/bluez/hci0/dev_00_12_EE_A6_1D_F4
>bluetoothd[6061]: Registered interface org.bluez.Input on path
>/org/bluez/hci0/dev_00_12_EE_A6_1D_F4
>
>If I pair the headset with a phone, I need to enter 0000 on the
>phone, after which there is a beeping in the headset until I press
>the headset  button and the pairing is complete.
>
>Did I miss something in the setup to use a bt headset or is the
>bluez-gnome logic not quite right for a headset?
>
>Q2 My os uses 2.6.26 and I have the following bt modules loaded:
>
>Module                  Size  Used by
>sco                     9472  2
>bnep                   11264  2
>rfcomm                 29328  4
>l2cap                  17920  16 bnep,rfcomm
>hci_usb                13084  3
>bluetooth              42852  11 sco,bnep,rfcomm,l2cap,hci_usb
>
>Do I need to apply the seven bt patches for 2.6.26 or will the
>headset work as is - i.e. is the btusb (?) module required for sco to work?
--------------------------
To answer my own question, things now work with bluez-4.15, 
bluez-gnome-1.8 and the hci_usb module - the btusb module freezes my 
machine on completion of pairing.

Perhaps not a big deal, but I still think bluez-gnome 
(bluetooth-wizard) could be a bit more user friendly when connecting 
to a bt headset (or other device where the use cannot enter a pin) - 
why not give the message "press button on headset" rather than "enter 
PIN 0000"?

Anyway, the sound playback/recording quality seems good. 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
