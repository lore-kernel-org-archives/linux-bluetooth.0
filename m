Return-Path: <cyrus@holtmann.org>
Message-Id: <1FD0D51A-B2E0-48C3-9D11-0F0E82CA5A08@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1224174684.22702.11.camel@alex-laptop>
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Thu, 16 Oct 2008 19:51:27 +0300
References: <1224174684.22702.11.camel@alex-laptop>
Subject: Re: [Bluez-devel] how to change volume for a2dp headset?
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Galaha,

On Oct 16, 2008, at 19:31, Galaha Shine wrote:
> I just wonder if it is possible to change a2dp headset volume by D-bus
> command?
>
> I notice there is a D-bus API SetSpeakerGain in bluez 3.36. I've try  
> it
> with my sco headset and it works. But it doesn't work when I try it  
> with
> a a2dp headset. Dbus returns an error that is unconnected. Then I
> download bluez 4.13 which is the latest build. I notice that API
> SetSpeakerGain becomes deprecated. Meanwhile I find control-api.txt
> which seems haven't been implemented yet.
>
> Could anybody give me a hint how to control a2dp headset from host  
> side
> by D-bus command?

The simple answer is that you can't do that at the moment. BlueZ has  
never supported controller (CT) side features of the AVRCP profile.  
There has been some talk about adding friendly D-Bus methods for this  
into the org.bluez.Control interface but it seems we forgot to add  
place holders for it into the control-api.txt API doc when the other  
new AVRCP features (that David Stockwell has worked on) were added  
there. I guess we should look into implementing this once David's  
patches get integrated upstream, but until then you'll have to control  
your A2DP volume from the headphone side.

Johan 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
