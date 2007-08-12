Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46BEDF61.2020401@free.fr>
Date: Sun, 12 Aug 2007 12:22:25 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
In-Reply-To: <1186855275.6698.10.camel@violet>
Subject: Re: [Bluez-devel] An explanation of a2dpd weird behaviour on	high
 resolution timers enabled kernels
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

Hi Marcel,

> Hi Fabien,
> 
>> I recently purchased a new combo A2DP/HFP headset from Sony Ericsson.
>> This was the first time i was able to try Frederic's a2dpd daemon. :-)
> 
> you might wanna focus on the Bluetooth audio service in bluez-utils (the
> code got committed today) which now has A2DP support.

Ho good, i'm gonna start having a look at it then !

> 
> Parts are based on the work from bluetooth-alsa, but the overall design
> concept is a little bit different. For example is the SBC encoding done
> inside the ALSA plugin and not inside the daemon. 

That's *great* news !! That always shocked me to have the sound data go 
through the sound daemon :-)

This allows us to
> avoid any unnecessary copying of data between processes. My laptop
> showed xmms running at 5% CPU and that includes MP3 decoding and then
> SBC encoding.

Agreed. + reduced latency :-)
> 
> I have seen some weird behavior with this when the playback speed is way
> to fast. This might be related or totally unrelated. I simply don't
> know.

I'm gonna start to play with it then.

I was planning to start some a2dp related work myself on it... if only 
it wasn't already done. :-)

Could you tell me who's working on the audio service ?
How should i submit patches / possible functionnal improvements to it 
(are the people working on it on the list)?

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
