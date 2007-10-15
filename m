Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47138547.80601@stuart.es>
Date: Mon, 15 Oct 2007 17:20:39 +0200
From: Stuart Pook <bluez16t@stuart.es>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] the SIP softphones ekiga & twinkle do not work with
	my headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hello

I have tried to get two different SIP softphones to work with bluez-3.20 
without success. Both of them hang when I use them with the microphone 
of my Plantronics M2500 Bluetooth headset. As they both have the same 
problem it is perhaps bluez-3.20 (or my configuration) that is at fault. 
As anyone else had more success? Which softphones work with bluez?

My ~/.asoundrc contains

pcm.M2500 {
         type bluetooth
         device "00:03:89:xx:xx:xx" # M2500 by Plantronics
}
pcm.!default {
         type plug;
         slave.pcm "M2500"
}

"arecord -f S16_LE|aplay" and "arecord -D M2500 -f S16_LE|aplay -D 
M2500" work fine (most times).

When I use the "Configuration Druid" in Ekiga (2.0.11) I can choose my 
headset as the "audio input device" (I choose default) and another sound 
card as the audio output device.  The "Test Setting" button works and 
what I say comes out of the speakers. When I make a call using these 
setting I can hear the other party but nothing is read from the 
microphone and when I try to hang up ekiga hangs.

When I configure twinkle (version 1.1) to use M2500 as the microphone 
and another device as the speaker, I don't hear anything when I call and 
when I try to end the call twinkle hangs.

Both programs fail in the same way if I use the headset as the speaker 
and microphone.

Both programs work fine if I use my headset as the speaker and another 
device as the microphone.

any ideas?
Stuart

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
