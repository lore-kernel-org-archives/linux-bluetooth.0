Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 22 Oct 2007 15:28:14 +0300
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>
In-Reply-To: <Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>
	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PATCH1/2: bluez-utils -fix-a2dp-buffer-constraints
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

On 18 Oct 2007,  Jim Carter wrote:
>I remember a month or two back, someone said that the A2DP 
>profile was weak on flow control, requiring the source (ALSA) 
>to send data at an even rate.  
>If the headset's buffer is full can it cork the stream?  Or 
>will the additional data just overwrite data already at the headset?

ok, I'm very new to A2DP, but my understanding is that timing 
is done similarly as in RTP-over-IP: the receiver adapts to
the clock of the sender. This means the sender just needs to 
send at a steady pace (not required, but makes life easier for
the receiver). And as with RTP, I assume implementations vary
a lot in quality, so improving the timing (reducing jitter 
and drift against nominal rate) will improve interoperability
between different devices.

Any ++agreed or --aggreed statements? :)

>With bluez-utils-3.19 (3.20 is latest) I'm having consistently 
>good results sending to the Bluetooth ALSA device, with 
>neither silent gaps nor lost chunks.  But I'm seeing 
>corruption when going through PulseAudio, which is attributed 
>to an unknown formatting or parameter issue and is being dealt 
>with on their mailing list.

Have you tested with my patches (now in CVS)? Vanilla 3.19/3.20
didn't work at all with Pulseaudio, but with my patches the
playback is now flawless.

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
