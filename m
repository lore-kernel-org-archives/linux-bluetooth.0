Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43302E11.5010103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] caching A2DP/alsa connection
References: <432CE905.6050006@xmission.com> <1127216847.5168.27.camel@localhost.localdomain>
In-Reply-To: <1127216847.5168.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Sep 2005 09:43:13 -0600

Marcel,

I've joined the gstreamer list and I'm looking into the docs some more 
before I ask them if gstreamer plugins can do everything we need. I hate 
to add a dependency, but if gstreamer is a more straightforward way to 
go and it's becoming mainstream, I don't mind requiring it.

Brad

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>I remember you were trying to keep the headset connection open between 
>>the quick audio device close and reopen that some clients like xmms do.
>>
>>I started thinking we need to put esd or another audio server or alsa 
>>layer between the apps and our libalsa a2dp connection. Could we extend 
>>the caching to work between different apps this way? We may even be able 
>>to use a soft mixer to get simultaneous clients...
>>
>>This is part of the reason I've been slow to jump in. It seems like I'd 
>>need to understand alsa up and down to know how to best make this work.
> 
> 
> even I have to look at it again, but what also came up lately is a
> native integration of A2DP as GStreamer plugin. Maybe you wanna start
> looking at that, because I never looked at any Code of the GStreamer
> project by now.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
