Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42357B08.7020009@dark-reality.de>
References: <1110683934.5056.43.camel@pc7.dolda2000.com>
	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
	 <42357B08.7020009@dark-reality.de>
Content-Type: text/plain
Message-Id: <1110808286.5056.87.camel@pc7.dolda2000.com>
Mime-Version: 1.0
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
Date: Mon, 14 Mar 2005 14:51:26 +0100

On Mon, 2005-03-14 at 12:52 +0100, Lars Grunewaldt wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> |>>On the bad side, the coding is pretty unelegant in its places, and I've
> |>>completely violated your coding style. Also, backward compatibility for
> |>>userspace communication is broken since I had to extend the structure
> |>>for incorporating usage status. I haven't updated the btsco2 program
> |>>either.
> 
> I really like the changes you made in this patch, but why don't you
> simply follow the coding style and send in a patch that's actually
> usefull to the community? It's not that hard to comply to coding
> style...? *scratchinghishead*
> 
> maybe you could fix the coding style and send it in again :)

Well, to be honest, it's because I didn't understand the coding style.
There are lots of linebreaks that I neither see the meaning of nor any
pattern in. So I just didn't know what to do. :)

> Is it possible to have the headset buttons work as they did without the
> patch, like, switching between both behaviours? there are scenarios for
> both methods, and even the BT specs cover both of them.

Well, at first I was thinking that one could simply code a config file
that opens the corresponding DSP or ALSA device with a cat process or
something. I realized later, though, that that would make the next
access block, since the ALSA driver can only handle one open at a time
(since there's just one substream). So right now, I have no obvious
answer to this, except possibly that one could have a signal interface
to the btsco daemon (send SIGUSR1 to connect and SIGUSR2 to disconnect,
for example), but since I used SIGUSR1 to ring the headset, I'm not sure
what signals to use. One could use SIGUSR2 to toggle the connection
status, but that seems so ugly...

Maybe the config file could be changed to run some internal command set
in the daemon instead, like this:

AT\+CKPD=200
sco-toggle
AT\+CHLD=2
system (whatever command to make gnomemeeting pick up, for example)

Or:

AT\+CKPD=200
sco-connect
AT\+CHLD=2
sco-disconnect

I'm not sure if the signal interface or config file extension is the
best, really, so I'd appreciate comments on that.

Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
