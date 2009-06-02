Return-Path: <cyrus@holtmann.org>
Message-ID: <4A251CA6.5090205@gdatech.co.in>
Date: Tue, 02 Jun 2009 18:05:50 +0530
From: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth Headset not working with Linux2.6.28 ubuntu Intrepid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear All,

I have a Bluetooth headset that support HSP. I am trying to make it work 
on the Ubuntu linux Intrepid version.
I am facing issue of the BT headset stops working after few seconds but 
after that btsco application hangs and even
after killing the application I could see that lot of SCO packets 
activity(confirmed using hcidump utility).

*Bluez version available on the ubuntu is 4.12*

_*Steps followed:*_
i) installed all the required bluetooth packages available for the 
Intrepid linux
ii) install bluetooth alsa driver
insmod snd-bt-sco.ko

snd-bt-sco we are got from the Bluetooth alsa site as follows:

http://bluetooth-alsa.sourceforge.net/build.html

cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/btsco login 
cvs -d:pserver:anonymous@sbc.cvs.sourceforge.net:/cvsroot/btsco co btsco

When tried to compile with the 2.6.28 kernel it returned driver.h is depreceated, we removed the header file entry
in the sourcecode and commented two or three lines which had snd-assert api which is not available in the linux-2.6.28 alsa.

*I would like to know where I can get the latest version of the snd-bt-sco driver.*

iii) connect to the audio headset using the
btsco -v <BTADDR>

iv) after performing the above we could see a soundcard entry in the
/proc/asound/cards

v) aplay -D btheadset -f s16_le /usr/share/sounds/login.wav

After the v) step we could here a sound and after few seconds the audio 
cuts off.

Please advice how to troubleshoot and fix this issue.

Thanks & Regards,
Benjamin
