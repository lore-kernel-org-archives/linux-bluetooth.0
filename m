Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B88BFD.8000907@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: starting btsco-in-libalsa
References: <41B81ACB.1080807@xmission.com> <1102589835.9988.114.camel@pegasus> <41B83BA8.5010001@suche.org>
In-Reply-To: <41B83BA8.5010001@suche.org>
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
Date: Thu, 09 Dec 2004 10:31:41 -0700

Thomas,

> i think this goes to the wrong direction.
> 1. Even if there exist alsa library for many programms it is sufficent 
> to use /dev/dsp and /dev/audio.
> This mean that the soundcard driver should work independent of the alsa 
> library.
...
> So what are the grounds for moving btsco to the lib inseat of moving it 
> to the module ?

I think Marcel explained sufficiently that this is how we can get 
handsfree and a2dp profiles working properly in the audio driver.

When we get the libalsa stuff going, there will be overlap in function 
with the current kernel module and daemon, but we can keep the kernel 
module in our project. As with everything open source, it'll be 
maintained by people who care about it.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
