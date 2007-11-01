Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 1 Nov 2007 17:11:51 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
In-Reply-To: <4729E570.6060202@free.fr>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>
	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>
	<4729E570.6060202@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <fabchevalier@free.fr>, <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Kai's experimental ALSA/A2DP plugin patch review
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

thanks for reviewing the patch! 

On 01 Nov 2007,  Fabien Chevalier wrote:
>I generated a patch from your latest pcm_bluetooth.c changes.
>Please find some comments below (look for ==> sequence for my 
>comments) :

btw, I've continued to test the patch and found out...
 - poll()'ing in current CVS code doesn't really work as
   'events' fields are not correctly set in hw_thread
 - but if you do enable the polling (of the L2CAP socket fd),
   the wakeups are far too frequent (and eat too much CPU time)
     - audio playback is OK, but spending 99% of CPU time is
       not really worth it ;)
     -> so unless there is a way to configure the L2CAP to 
        wake up only when "at least X bytes can be written", 
        the only sensible solution is a) blocking writes to
        the L2CAP socket, b) timer paced writes to L2CAP (which
        causes problems with some headsets, e.g. iMuff)

If noone comes up with a way to set a wakeup threshold for 
the L2CAP sockets, I'd propose the following steps forward:

(i) Merge some version (not ready yet) of my patch -> makes the plugin 
    compatible with apps such as Pulseaudio. Currently I'm not
    aware of any regressions over the CVS version. The only known 
    problematic headset is iMuff, but that doesn't work with
    CVS version of pcm_bluetooth.c either (but does work 
    with gsta2dpsink). So not a full solution, but at a step forward.
(ii) Write a version of the plugin in which a worker thread 
     does blocking writes to the L2CAP socket (implementation
     is then identical to gsta2dpsink). In this approach, hw_ptr
     is updated based on the blocking writes to L2CAP, not based on 
     system-timer.

I'm not sure yet, whether I have time to write (ii), but I'll
keep working on (i) for now.

Then some comments to your comments below...:

>-	ret = send(data->stream.fd, a2dp->buffer, a2dp->count,
MSG_DONTWAIT);
>
>==> MSG_DONTWAIT is there to prevent the l2cap socket to lock 
>us up, if for some (bad) reason the l2cap layer is not able to 
>send data at the right speed. I see no reason to change that !!

But if we use MSG_DONTWAIT, the send() will return an error every now 
as the L2CAP buffers are full (as our send()'s are paced by a system
timer, 
and are in no way synchronized to the actual L2CAP buffer status). And 
with our current plugin design, we have no way to handle this error
scenario without messing up the client timing (I've tried a lot
of things, but none of them work). :(

So until we implement (ii) approach (see above), I don't 
see any other solution than to drop MSG_DONTWAIT.

>  	if (io->hw_ptr > io->appl_ptr) {
>-		ret = bluetooth_playback_stop(io);
>-		if (ret == 0)
>-			ret = -EPIPE;
>-		goto done;
>+		/* Delegate XRUN handling to the headset. Here we just
>+		 * reset the virtual hardware pointer. */
>+		DBG("hw-ptr reset, hw_ptr=%lu appl_ptr=%lu diff=%lu.\n",
>+		       io->hw_ptr, io->appl_ptr, io->appl_ptr - 
>io->hw_ptr);
>+		io->hw_ptr = io->appl_ptr;
>  	}
>
>==> Could you explain why this change is needed ? It seems to 
>be pretty 
>bas to me as it is not *at all* in the ALSA philosophy to play magics 
>whith the hw_ptr, especially not bring it back in  the past !!

Well, the hw_ptr is really just a guesstimate in our plugin, as we
don't know how the headset is operating. We try to guess (and maintain
a system-timer paced hw_ptr of our own), but if we are wrong, 
the above happens. It doesn't make sense to stick to our interpretation
of hw_ptr as that will result in audible hickups in the headset.

If you revert the above segment of the patch, you'll get an XRUN
couple of times per minute on many headsets. And this is not 
process scheduling related, so not an actual XRUN, but instead is 
caused by drift against our guess of hw_ptr and the actual hw_ptr 
of the headset.

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
