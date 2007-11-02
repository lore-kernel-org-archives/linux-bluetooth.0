Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 2 Nov 2007 14:05:50 +0200
Message-ID: <719D5CCC2F6E3644B0A9F5C9B1D000880396F4D3@esebe104.NOE.Nokia.com>
In-Reply-To: <472A0CDB.50104@free.fr>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>	<4729E570.6060202@free.fr><719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
	<472A0CDB.50104@free.fr>
From: <Kai.Vehmanen@nokia.com>
To: <bluez-devel@lists.sourceforge.net>
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

Hi,

On 01 Nov 2007,  Fabien Chevalier wrote:
>For those too lazy to read this whole stuff : here is a quick status
>
>  * i noticed audible audio clicks while using rhythmbox and 
>my HBH DS970 headset: from my point of view the audio quality 
>is clearly inferior to what is in CVS today.

hmm, so that's with gstalsasink using pcm_bluetooth.c, right?
But yeah, one regression is enough, so back to the drawing 
board.

>>  - poll()'ing in current CVS code doesn't really work as
>>    'events' fields are not correctly set in hw_thread
>
>Could you be more specific on what doesn't work ? If this is 
>the poll() call in hw_thread, it is unused for now (i.e never 
>exits due to fd activity, but always on timeout).So that 
>wouldn't surprise me if it was kind of broken. ;-)

Yes, exactly that (they are not really polled).

>>  - but if you do enable the polling (of the L2CAP socket fd),
>>    the wakeups are far too frequent (and eat too much CPU time)
>
>You CAN'T throttle yourself by using the l2cap socket blocking call or
>poll() syscall. That causes some headsets to play too fast as 
>they have no mean to throttle the speed at which we send data 

Well, that's what I've thought so far, but then when I checked
gsta2dpsink (which seems to work better with more headsets than
pcm_bluetooth.c), it would seem to do just that. In

http://bluez.cvs.sourceforge.net/bluez/utils/audio/gsta2dpsink.c?revisio
n=1.13&view=markup

- 'self->stream' is set to blocking mode
- gst_a2dp_sink_render() just writes to the socket with seemingly
  blocking writes

... unless I misread the code (possible ;)), this seems to do 
exactly what I describe above (and unlike current pcm_bluetooth.c).

With which headsets the playback is too fast?

>> (ii) Write a version of the plugin in which a worker thread 
>>      does blocking writes to the L2CAP socket (implementation
>>      is then identical to gsta2dpsink). 
>
>As explaned above, this is not possible. If gsta2dpsink is 
>written that way today, then it needs to be fixed, not the 
>other way around. :-)

Hmm, but for instance gsta2dpsink works with the iMuff headset,
while the system-timer paced pcm_bluetooth.c doesn't.

>> I'm not sure yet, whether I have time to write (ii), but I'll keep 
>> working on (i) for now.
>
>Go for (i) then. Have you given up on rewriting the worker 
>thread so that it wakes up at regular intervals to send data 
>over the network ?

Not totally, but it would seem that starting any large-scale work is
kind of pointless without a truckload of different headsets available
for testing. Oh well, such is life. :(

>> But if we use MSG_DONTWAIT, the send() will return an error every now

>> as the L2CAP buffers are full (as our send()'s are paced by a system 
>> timer,
>
>This is exactly the right thing to do. We just have to ignore 
>this error and go forward. In no way we should block ourself 
>on the system call.

But as we don't have a real ringbuffer yet, we can't wait and
resend later (as by that time the application has provided us
with yet more data). We can of course stop the application, but
that will cause an XRUN (and audible glitch). Without MSG_DONTWAIT,
the write will block momentarily every now and then (every few minuts
with the headsets I've been testing with), and audio is glitch-free.

Oh well, but I guess we agree that a real ringbuffer would be
needed. 

>> and are in no way synchronized to the actual L2CAP buffer status).
And 
>> with our current plugin design, we have no way to handle this error 
>> scenario without messing up the client timing (I've tried a lot of 
>> things, but none of them work). :(
>
>See above, what you propose is not possible.

But it works with the headsets I've been testing with! Of course that
doesn't prove anything in the general case, just explaining how I
ended up with the proposal.

>> Well, the hw_ptr is really just a guesstimate in our plugin, as we 
>> don't know how the headset is operating. We try to guess (and
maintain 
>
>Kai, i think you're messing up your pointers ;-) The story 
>between hw_ptr and appl_ptr is purely an application<-->alsa 
>plugin interface issue, it has very little to do with the 
>actual headset hardware. And this is in no way (as least today 

Yes and no. If the hw_ptr is not synced to the headset, 
the application will write data too fast (leading
to either a send() error, or blocking send(), depending on
whether MSG_DONTWAIT is set or not).

>- i proposed an approach but until we actually find a headset 
>that breaks due to the lack of synchronisation i don't think 
>i'm gonna manage to convince anybody that this is really 
>usefull ;-) ) an estimate of the 'hw_ptr' for the headset.

Well, the problem realizes when you try to reduce the application
wakeups with pcm_bluetooth.c. The audio _does_ glitch for instance 
with Plantronics P590 (and fixed by "hw_ptr adjusting").

>> If you revert the above segment of the patch, you'll get an XRUN 
>> couple of times per minute on many headsets. And this is not process 
>> scheduling related, so not an actual XRUN, but instead is caused by 
>> drift against our guess of hw_ptr and the actual hw_ptr of the 
>> headset.
>
>See above, that doesn't make sense.

Well it does. When call to send() blocks (or returns EAGAIN), we've 
been writing data at an incorrect rate, and also updated hw_ptr at 
a wrong rate (w.r.t. to the L2CAP-socket/headset). Thus we need to
either
a) adjust hw_ptr (what my patch does), b) drop the packet (causes
an audible glitch).

>I've suffered real pain having this part of the code to work 
>(even if it's not perfect as you've noticed it), so has 
>frederic dalleau : if you want some tips to undersand why 

I can believe that! :) As I have very little experience with
Bluetooth (my background is with audio apps), I'm sure I'd 
have even more painful road ahead of me unless I follow your
footsteps here. It's definitely clear to me now, that I need to
get more headsets and/or spend more time reading the core
BT specs in order to propose solutions that work in the general
case. But I still want to emphasize that my patches are addressing 
real problems I can reproduce with real-life headsets and apps.
IOW, pulseaudio is still not working with CVS-HEAD of 
pcm_bluetooth.c. :(

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
