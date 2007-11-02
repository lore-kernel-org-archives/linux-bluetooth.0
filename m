Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 1 Nov 2007 22:49:03 -0400 (EDT)
From: David MacCormack <djm-list@maccormack.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47293B4E.60508@gmail.com>
Message-ID: <Pine.LNX.4.61.0711012227170.7841@gur-jnyy.znppbeznpx.arg>
References: <1In7ly-1gisng0@fwd33.aul.t-online.de>
	<1193847468.32459.40.camel@violet> <47293B4E.60508@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] VOIP bluetooth headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Thu, 1 Nov 2007, Mohan Sundaram wrote:

> I was able to use my Motorola BT headset with Skype on Gutsy.
> Mohan
>

Interesting.  I tried to get my Motorola BT headset working with Ekiga 
without any luck.  Since Ekiga doesn't allow one to select a virtual 
device I have to change the default device before loading Ekiga.  When I 
tell Ekiga to talk directly to the bluetooth device I get an error, 
something about full-duplex not being supported.  When I tell Ekiga to 
talk to the bluetooth device via PLUG it will play *very* choppy sound but 
not record.  Also, disconnecting the call locks Ekiga such that it has to 
be killed with sig 9.

The bluez ALSA driver works fine with mplayer/aplay/arecord/etc... so I'm 
guessing the problem is on Ekiga's end.  Is there some sort of flag that 
the bluetooth ALSA driver needs to set so that Ekiga thinks it's 
full-duplex?  Because piping arecord | aplay lets me both record and play 
sound on the headset just fine (using the voice profile, obviously).  So, 
besides the fact that "arecord | aplay" is two different processes, 
what's the difference between that and Ekiga that's making Ekiga barf? 
I took a quick peek at the Ekiga code and I couldn't tell.

Has anyone else tried bluez ALSA+Ekiga?  Any luck?

Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
