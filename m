Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 26 Oct 2007 16:31:22 +0300
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>
In-Reply-To: <471E2829.5020303@free.fr>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>
	<471E2829.5020303@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] experimental ALSA/A2DP plugin patch (was: RE:
	PATCH1/2: bluez-utils -fix-a2dp-buffer-constraints)
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

Hi,

On 23 Oct 2007,  Fabien Chevalier wrote:
>Except for the timing part, i'm not really sure the receiver 
>is that clever. I guess at least some of them will expect to 
>receive data with at their local clock speed...

hmm, based on further reading of the spec, I think the receivers
must be that clever. And this makes sense, as it's basicly RTP, 
so an off-the-shelf RTP receiver implementation would work
for the headsets.

And that assumption leads to an experimental patch (patch plus
patched pcm_bluetooth.c for convenience):

http://sofia-sip.org/~vehmanek/bluez-patches/patch-pcm_bluetooth-kv-2007
1025-works.txt
http://sofia-sip.org/~vehmanek/bluez-patches/pcm_bluetooth.c

 - send errors are now ignored (packets dropped), seems
   to have no bad side effects on the headsets I've tested
   with
     -> the positive impact is that we can more easily keep
	  up the correct timing even with bigger period sizes
 - a2dp_write() now loops'n'sends until all data submitted by
   the app is  encoded (needed to work with MMAP using clients)
 - allowed period sizes defined as set of values (vs range), 
   this works with for example pcm.c (seems to be an alsa-lib bug,
   but didn't have time to track it down)
 - period count fixed to 3 (seems to work best and still 
   doesn't confuse ALSA apps)

I've tested this with alsa-lib pcm.c, aplay, and pulseaudio, and all
seem to work better. But **NOTE**, I've only tested with limited
number of headsets, so it might be that ignoring send errors
causes audible glitches on some models. So feedback is very welcome!

If you can, please test this and report whether this improves (or 
degrades) the audio quality, and/or compatibility with ALSA apps 
you are using.

br,
-- 
first.surname@nokia.com (Kai Vehmanen)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
