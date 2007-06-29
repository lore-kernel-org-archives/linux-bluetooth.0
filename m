Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46852386.8050608@free.fr>
Date: Fri, 29 Jun 2007 17:21:42 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Bluez developer,

I'm trying to move forward on the design of the Bluez audio API. I'm 
gonna suggest some new methods and signals to handle HFP and A2DP, 
however at first i feel the need to understand the following methods and 
signals:

Methods:
--------
void Play()
void Stop()
uint16 GetSpeakerGain()
uint16 GetMicrophoneGain()
void SetSpeakerGain(uint16 gain)
void SetMicrophoneGain(uint16 gain)

Signals:
------------

void SpeakerGainChanged(uint16 gain)
void MicrophoneGainChanged(uint16 gain)

Here is the question : aren't those actions and events not supposed to 
be handled by the various ALSA plugins,
that would communicate using a dedicated unix socket ?

In fact i'm afraid of the following issues if those methods/signals are 
available:
 * An application could use snd_pcm_start to start playing, and another 
one could shut down the stream using
Stop() : the result would certainly be an unexpectedly broken stream.
 * Application developpers could be rather confused (Which one of Play() 
or snd_pcm_start should i use? Or maybe i should use both? In this case 
which one am i supposed to call first ?)
 * If the ALSA plugin is supposed to call those method by itself, this 
would mean bring dbus in each
application process' space, which is not that nice...
 * Gain management signals and functions are redundant with equivalent 
ALSA&GStreamer functions.

I hope this will bring some light on the expected use of those 
methods/signals...

Cheers,

Fabien






-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
