Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-1?Q?=22Marc_H=FClsey=22?= <marc.huelsey@gmx.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <10798.1138350079@www023.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-users] stream a2dp audio to pocket pc fails
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
Date: Fri, 27 Jan 2006 09:21:19 +0100 (MET)

Hey,

I’d like to stream audio from my linux pc to a pocket pc ( ce.net WM 2003
SE).

mpg123 --au - file.mp3 | sbc/sbcenc - | ./sbc/rcplay 00:0D:3C:30:32:AD –
./a2play -s -d -r 44100 00:0D:3C:30:32:AD /dev/dsp

The link is established and displayed as a2dp on both devices. The pocket pc
even 
receives packets from my linux pc but no audio is coming out of my pocket
device.
Where are these packets going?

If I receive the a2dp stream on my linux device via a2recv its works perect,
incredible quality!!

Greets marc   

-- 
Lust, ein paar Euro nebenbei zu verdienen? Ohne Kosten, ohne Risiko!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
