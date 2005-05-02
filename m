Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <427670B5.2060708@citromail.hu>
From: =?ISO-8859-2?Q?Szil=E1gyi_Szilveszter?= <sszilveszter@citromail.hu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] internal bluetooth on laptop
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 02 May 2005 20:25:57 +0200

hi,
I have an ibm thinkpad laptop with an internal bluetooth
with my external usb-bluetooth key I can use my mobile phone
but I cannot use my internal bluetooth,
the hciconfig cannot find my internal bluetooth, so I cannot use
hciconfig hci0 up && hcitool scan && rfcomm connect 0 00:09:D9:26:70:46 2

because hciconfig gives error:
root:~# hciconfig hci0 up
Can't get device info: No such device

(with the external key
root:~# hciconfig hci0 up
root:~#
)



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
