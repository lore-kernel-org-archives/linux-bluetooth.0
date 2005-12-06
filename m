Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43959F07.2090105@pagestation.com>
From: Jerry Geis <geisj@pagestation.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] no audio on plantronics headset
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
Date: Tue, 06 Dec 2005 09:24:07 -0500

I have a kensington usb bluetooth adapter 2.0 with a plantronics 510 headset.
When a call is coming from asterisk (chan_bluetooth) with Dial(BLT/PLANTRONICS-HS)
my headset hears the ringing. I press my answer call button and I get NO audio...
I see below there is an error

process_rfcomm_cmd: Unknown AT Command: 'AT+VGM=15' (+VGM=15)

What do I do???

Thanks,

Jerry


------------------------

 [HS] PLANTRONICS-HS < +CIND: ("service",(0,1)),("call",(0,1)),
("callsetup",(0-4))
 [HS] PLANTRONICS-HS < OK
 [HS] PLANTRONICS-HS > AT+CIND?
 [HS] PLANTRONICS-HS < +CIND: 1,0,0
 [HS] PLANTRONICS-HS < OK
 [HS] PLANTRONICS-HS > AT+CMER=3, 0, 0, 1
 [HS] PLANTRONICS-HS < OK
 [HS] PLANTRONICS-HS > AT+VGS=00
 [HS] PLANTRONICS-HS < OK

*CLI> bluetooth show peers
BDAddr            Name       Role Status      A/C SCOCon/Fd/Th Sig
----------------- ---------- ---- ----------- --- ------------ ---
00:03:89:53:FD:3A PLANTRONICS-HS HS   Ready       Yes -1/-1/0      N/A
    -- Accepting UNAUTHENTICATED call from 192.168.1.10:
       > requested format = gsm,
       > requested prefs = (gsm),
       > actual format = gsm,
       > host prefs = (gsm),
       > priority = mine
    -- Executing Dial("IAX2/192.168.1.10:4569-1", "BLT/PLANTRONICS-HS")
in new stack
 [HS] PLANTRONICS-HS < +CIEV: 3,1
 [HS] PLANTRONICS-HS < RING
    -- Called PLANTRONICS-HS
    -- BLT/PLANTRONICS-HS is ringing
 [HS] PLANTRONICS-HS > ATA
 [HS] PLANTRONICS-HS < +CIEV: 2,1
 [HS] PLANTRONICS-HS < +CIEV: 3,0
 [HS] PLANTRONICS-HS < OK
    -- BLT/PLANTRONICS-HS answered IAX2/192.168.1.10:4569-1
Dec  6 09:10:18 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:621
sco_thread: SCO thread started on f d 33, pid 3721
 [HS] PLANTRONICS-HS > AT+VGM=15
Dec  6 09:10:19 WARNING[3736]: chan_bluetooth/chan_bluetooth.c:2381
process_rfcomm_cmd: Unknown AT Command: 'AT+VGM=15' (+VGM=15)
 [HS] PLANTRONICS-HS < ERROR
Dec  6 09:10:19 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:685
sco_thread: Wrote <48 to sco
Dec  6 09:10:19 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:685
sco_thread: Wrote <48 to sco
Dec  6 09:10:19 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:685
sco_thread: Wrote <48 to sco
Dec  6 09:10:19 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:685
sco_thread: Wrote <48 to sco
Dec  6 09:10:19 WARNING[3747]: chan_bluetooth/chan_bluetooth.c:685
sco_thread: Wrote <48 to sco



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
