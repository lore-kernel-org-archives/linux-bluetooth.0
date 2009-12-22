Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Dec 2009 18:10:11 +0900
Message-ID: <ca39c8ec0912220110h4938395ch584912ed0dc3a2eb@mail.gmail.com>
Subject: Re a2dp control functions
From: Asutosh Das <das.asutosh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I have compiled bluez 3.36 for arm and am able to play and listen mp3
files on a bluetooth headset (590plantronics). I am using mplayer to
play the music. When I press the volume up and down the volume gets
increased and decreased properly. So far so good. But the forward and
backward buttons donot respond at all neither do the play/pause.

I ran the hcid as hcid -nd & and it gave me some prints as below :-

hcid[1033]: AVRCP command 0x0, subunit_type 0x09, subunit_id 0x0,
opcode 0x7C, 2 operands
hcid[1033]: AVRCP: PREV pressed
hcid[1033]: Got 8 bytes of data for AVCTP session 0x2a06e158
hcid[1033]: AVCTP transaction 3, packet type 0, C/R 0, IPID 0, PID 0x110E

hcid[1033]: AVRCP command 0x0, subunit_type 0x09, subunit_id 0x0,
opcode 0x7C, 2 operands
hcid[1033]: AVRCP: PREV released
hcid[1033]: Got 8 bytes of data for AVCTP session 0x2a06e158
hcid[1033]: AVCTP transaction 4, packet type 0, C/R 0, IPID 0, PID 0x110E

hcid[1033]: AVRCP command 0x0, subunit_type 0x09, subunit_id 0x0,
opcode 0x7C, 2 operands
AVRCP: Play Called
hcid[1033]: AVRCP: PLAY pressed
hcid[1033]: Got 8 bytes of data for AVCTP session 0x2a06e158
hcid[1033]: AVCTP transaction 7, packet type 0, C/R 0, IPID 0, PID 0x110E


AVRCP: Play Called
hcid[1033]: AVRCP: PLAY released
hcid[1033]: Got 8 bytes of data for AVCTP session 0x2a06e158
hcid[1033]: AVCTP transaction 8, packet type 0, C/R 0, IPID 0, PID 0x110E

So it seems that the device is getting the control packets from the
headset but for some reason it aint received by mplayer !!!

The mplayer doesn't seem to respond to these commands and just keeps
playing ....

My asound.conf looks like

pcm.bluetooth {
        type bluetooth
        device "00:19:7F:6F:6E:83"
        profile "auto"
}
ctl.bluetooth {
        type bluetooth
        device "00:19:7F:6F:6E:83"
        profile "auto"
}

Am I missing something ?


--
Thank you,
Warm Regards,
Asutosh Das
