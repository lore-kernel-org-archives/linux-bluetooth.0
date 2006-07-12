Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44B48F1E.1010006@xmission.com>
Date: Tue, 11 Jul 2006 23:56:46 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44AE84D4.9080903@palmsource.com>
In-Reply-To: <44AE84D4.9080903@palmsource.com>
Subject: Re: [Bluez-devel] Alsa plugin for A2DP daemon
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

I've been trying out your mixer/ipc server. It is a great step forward,
so I have committed it to our project.

>     I've been working with Brad's a2dp plugin for some time now. I =

> hacked it with the idea of having an ipc alsa plugin and an audio daemon =

> and guess what : today, I have something working pretty well. It fully =

> separate the application and the headset (tcp used for ipc). Thus, you =

> can let the application play audio while having the heaset switched off. =


using this server I can finally launch gxine with my r35 set. gxine
rapidly opens/closes the audio device several times in a row and that
gives the headset trouble without your server in the middle.

> Switch on the headset and you will start hearing sound. It also permit =

> having lots of applications using the headset at a time and yes, sound =

> is mixed. You can crash and restart the daemon without interrupting the =

> app. Reverse is possible too.

Do you have something in mind for routing audio to the speakers when the
 bluetooth headset is not available or if the user chooses to disable it?

Is a2dpd starting the connection to the headset on demand? If you do go
that route, make sure it holds the connection open for a few seconds
after the last client closes it.

>     Drawbacks : some ticks in the sound, Tcp may give additionnal burden =

> but for now it seems far from being cpu intensive (if you consider Xeon =

> as being a representative cpu ;).

these ticks are the sound you usually get when packets are sent too
quickly. so the audio using gxine has a bit of a delay and the pitches
of everybody's voices are too low. seems like a straightforward timing
issue.

Brad


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
