Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <472A0CDB.50104@free.fr>
Date: Thu, 01 Nov 2007 18:28:59 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <719D5CCC2F6E3644B0A9F5C9B1D00088038171C2@esebe104.NOE.Nokia.com><471730B2.3030606@free.fr>	<Pine.LNX.4.64.0710181017560.28683@simba.math.ucla.edu><719D5CCC2F6E3644B0A9F5C9B1D0008803840FC4@esebe104.NOE.Nokia.com>	<471E2829.5020303@free.fr>	<719D5CCC2F6E3644B0A9F5C9B1D00088038C8C83@esebe104.NOE.Nokia.com>	<4729E570.6060202@free.fr>
	<719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
In-Reply-To: <719D5CCC2F6E3644B0A9F5C9B1D00088039392F0@esebe104.NOE.Nokia.com>
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

Hi Kai,

Please find below some comments.

For those too lazy to read this whole stuff : here is a quick status

  * i noticed audible audio clicks while using rhythmbox and my HBH 
DS970 headset: from my point of view the audio quality is clearly 
inferior to what is in CVS today.
  * as such this patch is not ready for inclusion, furthermore it still 
has some design flaws (see below).
  * if Kai goes on with he's good work, i have no doubt he's gonna come 
up with something quite good in the future :-) ... but for now we're not 
there yet.

> Hi Fabien,
> 
> thanks for reviewing the patch! 
> 
> On 01 Nov 2007,  Fabien Chevalier wrote:
>> I generated a patch from your latest pcm_bluetooth.c changes.
>> Please find some comments below (look for ==> sequence for my 
>> comments) :
> 
> btw, I've continued to test the patch and found out...
>  - poll()'ing in current CVS code doesn't really work as
>    'events' fields are not correctly set in hw_thread

Could you be more specific on what doesn't work ? If this is the poll()
call in hw_thread, it is unused for now (i.e never exits due to fd 
activity, but always on timeout).So that wouldn't surprise me if it was 
  kind of broken. ;-)


>  - but if you do enable the polling (of the L2CAP socket fd),
>    the wakeups are far too frequent (and eat too much CPU time)
>      - audio playback is OK, but spending 99% of CPU time is
>        not really worth it ;)
>      -> so unless there is a way to configure the L2CAP to 
>         wake up only when "at least X bytes can be written", 
>         the only sensible solution is a) blocking writes to
>         the L2CAP socket, b) timer paced writes to L2CAP (which
>         causes problems with some headsets, e.g. iMuff)

You CAN'T throttle yourself by using the l2cap socket blocking call or 
poll() syscall. That causes some headsets to play too fast as they have 
no mean to throttle the speed at which we send data to them. In fact 
this is the first implementation people do, until they discover that it
breaks with some headsets (Luiz started with that, as well as people at 
my company who wrote an A2DP implementation)

> 
> If noone comes up with a way to set a wakeup threshold for 
> the L2CAP sockets, I'd propose the following steps forward:
> 
> (i) Merge some version (not ready yet) of my patch -> makes the plugin 
>     compatible with apps such as Pulseaudio. Currently I'm not
>     aware of any regressions over the CVS version. The only known 
>     problematic headset is iMuff, but that doesn't work with
>     CVS version of pcm_bluetooth.c either (but does work 
>     with gsta2dpsink). So not a full solution, but at a step forward.
> (ii) Write a version of the plugin in which a worker thread 
>      does blocking writes to the L2CAP socket (implementation
>      is then identical to gsta2dpsink). 

As explaned above, this is not possible. If gsta2dpsink is written that 
way today, then it needs to be fixed, not the other way around. :-)

In this approach, hw_ptr
>      is updated based on the blocking writes to L2CAP, not based on 
>      system-timer.
> 
> I'm not sure yet, whether I have time to write (ii), but I'll
> keep working on (i) for now.

Go for (i) then. Have you given up on rewriting the worker thread so 
that it wakes up at regular intervals to send data over the network ?

> 
> Then some comments to your comments below...:
> 
>> -	ret = send(data->stream.fd, a2dp->buffer, a2dp->count,
> MSG_DONTWAIT);
>> ==> MSG_DONTWAIT is there to prevent the l2cap socket to lock 
>> us up, if for some (bad) reason the l2cap layer is not able to 
>> send data at the right speed. I see no reason to change that !!
> 
> But if we use MSG_DONTWAIT, the send() will return an error every now 
> as the L2CAP buffers are full (as our send()'s are paced by a system
> timer, 

This is exactly the right thing to do. We just have to ignore this error 
and go forward. In no way we should block ourself on the system call.

> and are in no way synchronized to the actual L2CAP buffer status). And 
> with our current plugin design, we have no way to handle this error
> scenario without messing up the client timing (I've tried a lot
> of things, but none of them work). :(

See above, what you propose is not possible.

> 
> So until we implement (ii) approach (see above), I don't 
> see any other solution than to drop MSG_DONTWAIT.
> 
>>  	if (io->hw_ptr > io->appl_ptr) {
>> -		ret = bluetooth_playback_stop(io);
>> -		if (ret == 0)
>> -			ret = -EPIPE;
>> -		goto done;
>> +		/* Delegate XRUN handling to the headset. Here we just
>> +		 * reset the virtual hardware pointer. */
>> +		DBG("hw-ptr reset, hw_ptr=%lu appl_ptr=%lu diff=%lu.\n",
>> +		       io->hw_ptr, io->appl_ptr, io->appl_ptr - 
>> io->hw_ptr);
>> +		io->hw_ptr = io->appl_ptr;
>>  	}
>>
>> ==> Could you explain why this change is needed ? It seems to 
>> be pretty 
>> bas to me as it is not *at all* in the ALSA philosophy to play magics 
>> whith the hw_ptr, especially not bring it back in  the past !!
> 
> Well, the hw_ptr is really just a guesstimate in our plugin, as we
> don't know how the headset is operating. We try to guess (and maintain
> a system-timer paced hw_ptr of our own), but if we are wrong, 
> the above happens. It doesn't make sense to stick to our interpretation
> of hw_ptr as that will result in audible hickups in the headset.

Kai, i think you're messing up your pointers ;-)
The story between hw_ptr and appl_ptr is purely an application<-->alsa 
plugin interface issue, it has very little to do with the actual headset 
hardware. And this is in no way (as least today - i proposed an approach 
but until we actually find a headset that breaks due to the lack of 
synchronisation i don't think i'm gonna manage to convince anybody that 
this is really usefull ;-) ) an estimate of the 'hw_ptr' for the headset.


> 
> If you revert the above segment of the patch, you'll get an XRUN
> couple of times per minute on many headsets. And this is not 
> process scheduling related, so not an actual XRUN, but instead is 
> caused by drift against our guess of hw_ptr and the actual hw_ptr 
> of the headset.

See above, that doesn't make sense.
I think you must be somewhat mixing up different issues at the same time 
  :-(

I've suffered real pain having this part of the code to work (even if 
it's not perfect as you've noticed it), so has frederic dalleau : if you 
want some tips to undersand why things are as they are today and what 
other people have tryed before you, feel free to ask me on IRC

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
