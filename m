Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 17 Oct 2007 17:36:58 +0300
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D0008803817127@esebe104.NOE.Nokia.com>
In-Reply-To: <4715E28A.3080009@free.fr>
References: <000001c80cca$eff9ed00$c72915ac@NOE.Nokia.com>	<4711FB4D.2010609@free.fr><000601c80f19$b92b2270$0f9db70a@NOE.Nokia.com>
	<4715E28A.3080009@free.fr>
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

Hi Fabien,

On 17 Oct 2007,  Fabien Chevalier wrote:
>I'm quite interested in optimizations for low end ARM boxes 
>:-) Could you provide CPU details and the player you used to 
>performed your testing ? I'd like to be able to reproduce 
>those on my Neo1973 box :-)

:) I'm using an x86 system myself (2.66GHz P4). Just try running 
pulseaudio plus for instance "aplay -D pulse foo.wav" (or paplay) and 
you should see similar results. With the above system and  
unpatched 3.19, I get 2x number of gettimeofday()s, plus audio play 
out is as described in my earlier mails (choppy, so not really working),

compared to running the same test with patched 3.19. And this with 
default settings (i.e. not optimizing for a larger period size which 
would further minimize the system call load).

Anyways, this is definitely not specific to any hardware architecture 
nor CPU processing power. You can simply calculate the number of
unnecessary 
system calls and context switches. Whether those are enough to degrade 
audio quality is another question, but nevertheless you are wasting CPU 
cycles, using more electricity, accelerating global warming, etc, etc :)


>Maybe we should drop SND_PCM_IOPLUG_HW_PERIODS and keep 
>SND_PCM_IOPLUG_HW_BUFFER_BYTES only then ?

Hmm, that should be ok. I guess alsa-lib won't allow applications
to use only one period anyways, so not specifying that in
pcm_bluetooth.c 
should be ok.

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
