Return-Path: <snd-bt-sco-return-49-marcel=holtmann.org@corinis.net>
List-Post: <mailto:snd-bt-sco@corinis.net>
List-Help: <mailto:snd-bt-sco-help@corinis.net>
List-Unsubscribe: <mailto:snd-bt-sco-unsubscribe@corinis.net>
List-Subscribe: <mailto:snd-bt-sco-subscribe@corinis.net>
Reply-To: snd-bt-sco@corinis.net
Message-ID: <41604792.8030309@xmission.com>
Date: Sun, 03 Oct 2004 12:40:18 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: snd-bt-sco@corinis.net,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <41603BF5.9030405@superbug.co.uk>
In-Reply-To: <41603BF5.9030405@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [snd-bt-sco] bluetooth headset profile with alsa in user space.
List-ID: <bluez-users.lists.sourceforge.net>

James,

I've looked at this too. I'm crossposting to see if Marcel wants to comment.

Some people think bluetooth-alsa should have a smaller kernel footprint 
and some people think it's the userspace component that needs to be 
eliminated. The bottom line is that it needs to go in a direction that 
is acceptable to bluez and alsa but doesn't leave so much to be desired 
by the bluez group that they feel like reimplementing/rejecting it.

the less-kernel-space argument

- alsa would not be affected [much]
- bluez would only be affected in that we may want hooks to go into 
libbluetooth
- userspace stuff is easier to debug and develop
- supporting multiple headsets simultaneously should be more straightforward
- kernel developers won't be questioning it
- adding it to a linux distro that has bluez already would be easier

The more-kernel-space argument:

- alsa has said they would consider patches that don't have the 
userspace entanglements
- the bluez project leaders may decide that in-kernel is the way audio 
has to be done
- dbus/hotplug may play nicer with an in-kernel driver

I think now the less-kernel-space is safer. Regardless of our approach, 
apps that want bluetooth-alsa like asterisk will have to be linked with 
a new library so there's not a disadvantage there with another build 
requirement. There's probably just too much uncertainty with the 
in-kernel approach.

Brad

James Courtier-Dutton wrote:
> It is possible to implement an alsa device is user space, without 
> requiring any kernel modules. An example of this the the pcm_jack.c file 
> in:
> ./alsa-lib/src/pcm/ext/pcm_jack.c
> 
> It basically makes jackd look like a sound card to any alsa application.
> 
> This should help, because the bluetooth profile code is in user space as 
> well, so we could make the bluetooth profile look like an alsa sound card.
> 
> Any comments?
> 
> James
> 
> 
