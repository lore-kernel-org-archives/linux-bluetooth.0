Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 7 Jan 2010 15:01:20 +0530
Message-ID: <912bb79a1001070131p6621cf32ke452d49e05f7483d@mail.gmail.com>
Subject: SetMicrophoneGain & SetSpeakerGain API problem
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am using bluez 4.58 stack, I am able to connect, & disconnect HS
with bluetoothd. Also I am able to access API provided in bluez for
manager , adapter & headset etc.

I am using HCI layer only for SCO connection and rest of the
functionality for HS (connection, disconnection properties information
) am using D-BUS API.

But When I call SetMicrophoneGain/ SetSpeakerGain with gain
value(0-15),  GetProperties gives following message

(SpeakerGain - 11 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
10], "MicrophoneGain" = [Varinat(ushort): 6]}]))

(SpeakerGain - 10 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
10], "MicrophoneGain" = [Varinat(ushort): 6]}]))

(SpeakerGain - 7 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
7], "MicrophoneGain" = [Varinat(ushort): 6]}]))

(SpeakerGain - 15 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
15], "MicrophoneGain" = [Varinat(ushort): 6]}]))

(MicrophoneGain - 8 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
10], "MicrophoneGain" = [Varinat(ushort): 8]}]))

(MicrophoneGain- 4)
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
7], "MicrophoneGain" = [Varinat(ushort): 4]}]))

(MicrophoneGain - 11 )
QDBusMessage(type=MethoReturn,
service=":1.0",signature="a[sv]",contents=([Argument: a{sv} {"Playing
=[Variant(bool):false],"State" = [Variant(QString):"connected",
"Connected" = [Variant(bool):true], "SpeakerGain"  = [Variant(ushort):
15], "MicrophoneGain" = [Varinat(ushort): 11]}]))

So when I use GetProperties its shows that gain for Microphone and
Speaker has changed but actually it has no impact on HS.
Is this a right way to set gain for Mic and Speaker of HS. Or I must
do it though RFCOMM socket

Why API doesn't have any impact even though values are getting changed.

Any help will be appreciable.
-- 
With Regards,
Nirav Rabara
