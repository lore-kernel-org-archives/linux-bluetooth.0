Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20041012080501.GB5702@ruessel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: rossol@yola.in-berlin.de (Florian Rossol)
Subject: [Bluez-users] Using a k700i as HID-Device
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
Date: Tue, 12 Oct 2004 10:05:01 +0200

Hi,

I've some troubles using a Sony Ericsson k700i as a
HID-Device:

$ hcitool scan
Scanning ...
        00:0F:DE:15:FD:E9       K700i
$ hidd --server
$ hidd --connect 00:0F:DE:15:FD:E9
HID create error 110 (Connection timed out)

After the last command (hidd --connect ...) a window on the mobile
phone pops up: "Start remote control?". When I choose yes the remote
control on the mobile phone starts. But when I use the remote control
nothing happens on the pc. Also there is no message in
/var/log/daemon.log for a new HID-Device. But there is
Bluetooth-traffic at the moment when I use the remote control as I can
see on the LED on the Bluetooth-Stick. After some time (perhaps a
miniute) the "hidd --connect ..."-command exits with the error-message
above.

My system: Debian Sarge (kernel 2.6.8, bluez-utils 2.9).

Any hints?

Thanks

Florian

--=20
 gpg-key: http://yola.in-berlin.de/rossol.gpg=20
=20
 Bitte keine Dateien in propriet=E4ren Formaten versenden.
 Siehe http://www.fsf.org/philosophy/no-word-attachments.de.html
      =20


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
