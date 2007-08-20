Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C9E453.7020604@free.fr>
Date: Mon, 20 Aug 2007 20:58:27 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C875BA.90204@free.fr>	<2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>	<46C9D2E0.5050404@free.fr>
	<2d5a2c100708201111s5d73b6b6qdbef9c399cb3b3a7@mail.gmail.com>
In-Reply-To: <2d5a2c100708201111s5d73b6b6qdbef9c399cb3b3a7@mail.gmail.com>
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
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

>> Oh... about this bitrate stuff i must say i'm quite confused : where did
>> you find anything in the spec ? (I have A2DP 1.0 but didn't find
>> anything :-( )
> 
> Spec 1.2 is already available, but even in it is difficult to find as it is
> in Appendix part 12.9 page 66. Im not sure if the rate is mandatory
> or not, but as we have some headsets surfer from speed problem
> it might be a rate issue.

Ok thanks, i'm gonna have a closer look to it then. :-)

> 
>>> I also implement a circular
>>> buffer for encoded sbc frames to be consumed by a
>>> thread.
>> That was another option, however it was not that clear what the benefits
>> from it would be, so i took the easiest to implement alternative, and
>> just sent data as they arrived ;-)
> 
> It seems it is not always the case we are ready to send right away,
> this is what Im trying to figure out since the buffer sometimes got
> full (encoding process is too fast) or even (weird) I got no frames
> to sent on time thread (encoding too slow).

I think these issues you have (too fast, too slow) is because the poll() 
support in your version of pcm_bluetooth is broken.
I suggest you have a look at the pulse and jack plugin (available in 
lastest alsa-plugins), and also to my patch to see how it fits in the 
picture.

A correct implementation of poll is the only way you will be able to 
wake up the application only when you are ready to accept more data.
This means you must never block in the  bluetooth_a2dp_write functions, 
either explicitely (through pthread_mutex_lock for instance :-) ) or 
implicitely (using a blocking send call on a socket for instance).
The blocking is done by libasound itself, by polling on the fd's you 
give to it.

If you have any questions i'm gonna try to be o IRC tomorrow.

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
