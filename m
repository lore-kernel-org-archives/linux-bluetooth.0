Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 26 Mar 2010 11:12:57 +0800
Message-ID: <f163bb471003252012o2d6e72bep723847cc1317e69c@mail.gmail.com>
Subject: Small issue to receive "org.bluez.AudioSource" dbus message
From: dove xia <dovexia@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

	This is Dove as a new comer to Linux-bluetooth group.
	
	Currently, I am developing BlueZ stack works as A2DP Sink. After the
BlueZ runs, it works smoothly. I have developed a program run on Linux
user space to catch the BlueZ DBus messages. But the program can't
receive DBus messages from "org.bluez.AudioSource".
	I have test the BlueZ works as source before, I can receive DBus
messages from  "org.bluez.AudioSink".
	
	The test step is:
	1. Update the audio.conf to set the bluetooth works as A2DP Sink.
	2. Set the bluetooth into discoverable mode.
	3. Use another bluetooth device (a mobile), search and connect BlueZ.
	3. Play music from mobile.
	4. use a test program on Linux user space to catch the BlueZ
AudioSource DBus messages.
	The test case will expect the test program can catch the AudioSource
dbus messages, but it failed.
	
	I have traced the BlueZ source code, found a little clew in
audio/a2dp.c, the function sbc_setconf_ind() and mpeg_setconf_ind()
have not called source_new_stream() while the a2dp_sep->type is
AVDTP_SEP_TYPE_SINK, I patched code to call source_new_stream().
base on BlueZ 4.62, in audio/a2dp.c

@@ -341,6 +341,8 @@

 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
 		sink_new_stream(dev, session, stream);
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+		source_new_stream(dev, session, stream);

 	return TRUE;
 }
@@ -445,6 +447,8 @@

 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
 		sink_new_stream(dev, session, stream);
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+		source_new_stream(dev, session, stream);

 	return TRUE;
 }

	After I patched the code, my test program can receive the
"org.bluez.AudioSource" DBus messages. the BlueZ work smoothly as
before. so I think this is a correct fix.

	Need your confirm.
	
-- 
BR
Dove
