Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20110301192526.031f7c30@gmx.net>
Date: Tue, 01 Mar 2011 19:26:57 +0100
To: linux-bluetooth@vger.kernel.org
From: Peter Kornatowski <pkorn@gmx.net>
Subject: headset answer button with HFP and telephony-dummy
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to catch the answer button signal of a bluetooth headset when 
connected in HFP mode (HSP is trivial through the dbus-headset-signal 
"AnswerRequested"). I don't want to use the computer as the "headset 
part", but as the "audio gateway part". I have a small self-build app 
that can handle VoIP-calls and Bluetooth-audio through bluez and 
pulseaudio. Now I want the app to recognize the answer button being 
pressed and then answer or hang up a call. I know that it has to be 
done through a telephony-dummy because of the more complicated HFP 
state machine. So I also digged into the source of the corresponding 
.c files and searched the web. But I still have several questions left:
1. The bluez bindings for ofono and maemo seem to be just fulfilling 
the "headset part", so when connecting a mobile phone to the computer 
through Bluetooth. But I need the other direction. Is this possible 
with ofono or maemo?
2. I found this patch on the web: 
http://whitequark.livejournal.com/20590.html. It is already 
integrated into bluez (since version 4.6x), so my problem seems to be 
possible to solve with the telephony-dummy. But I tested it and when 
the headset is in connected mode, I don't receive anything when 
pressing the answer button. In playing mode I just received "AT+BLDN" 
(last_dialed_number) and "AT+CHUP" (terminate_call). But according to 
the patch I should receive "AT+BVRA" (voice_dial). Should the headset 
be in some state (if yes, in which one and how do I trigger it)?
3. Should I be able to use the dbus-methods in the telephony-dummy to 
simulate a "HFP state machine" and maybe be able to catch the answer 
button then? But here only the "audio gateway role" on the remote 
device (org.bluez.HeadsetGateway) is documented in the audio-api.txt, 
not the other direction.

Thanks,
Peter Kornatowski 

