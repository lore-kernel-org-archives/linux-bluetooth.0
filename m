Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <423589B1.6000403@xmission.com>
References: <1110683934.5056.43.camel@pc7.dolda2000.com>
	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
	 <423589B1.6000403@xmission.com>
Content-Type: text/plain
Message-Id: <1110809103.5056.102.camel@pc7.dolda2000.com>
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
Date: Mon, 14 Mar 2005 15:05:03 +0100

On Mon, 2005-03-14 at 05:55 -0700, Brad Midgley wrote:
> Fredrik
> 
> >>> * Instead of (dis)connecting with the headset button, the driver
> >>>notifies userspace when it is in use, and the userspace program connects
> >>>accordingly.
> >>> * Send SIGUSR1 to the userspace program to make the headset ring.
> >>> * The userspace program now reads a config file, ~/.btscorc, which
> >>>contains alternating lines of regexes and shell commands. Everything
> >>>that the headset sends is matched against these regexes, and if a match
> >>>if found, the shell command is run (with any back references replaced).
> >>>This, of course, is primarily intended to "do stuff" with the headset
> >>>button(s). Send SIGHUP to re-read the config file.
> 
> Can you comment on what the implications are for supporting multiple 
> headsets simultaneously with a single btsco daemon? Would the kernel 
> interaction need to be changed again or could it be limited to the daemon?

Well, if you ask me, that's just unnecessary.  It would add a lot of
complexity to the btsco daemon, for no obvious purpose. I believe that
if one wants multiple headsets, one should simply run multiple instances
of the btsco daemon. It's much simpler, for both the programmer and the
user. That's one of the reasons why I didn't update btsco2. ;-)
Handling multiple headsets in one daemon instance also breaks signalling
-- you can't decide which headset to ring by sending a signal to one
daemon handling many headsets, for example. All in all, I don't see the
reason to increase the complexity of the daemon with what I see as
nothing in return.

Also, the kernel driver would have to be changed either way, since it
only supports one single headset right now, whatever you do in
userspace. I'm not sure what to do about the kernel driver. Maybe add a
module parameter that specifies the number of Headset "cards" to
register? I think it's either that, or a miscdevice that can be used to
register another "card" at runtime.

There are, however, other things that should be done with the userspace
daemon. First of all, I'm thinking that if multiple headsets are to be
supported, the config file should be extended to accept "blocks" of
regex/command pairs -- one block for each headset. That would also help
pairing a headset to a name. For example, the config file could look
like this:

hs1 00:01:02:03:04:05
	AT\+CKPD=200
	... more commands
hs2 06:07:08:09:0a:0b
	AT\+CKPD=200
	... more commands

Then, the btsco daemon could be called like "btsco -f hs1" and "btsco -f
hs2", hs1 and hs2, of course, representing the names of the headsets.

Also to support multiple headsets, the daemon would need a way of
specifying what "card" to use.

Another thing, that I'm not sure is a good idea, is to implement a
"fail-safe" mode in the daemon. Running the daemon in fail-safe mode
would mean that it doesn't die from not being able to connect to the
headset. Instead, it would try to reconnect periodically. Same thing if
the connection is lost at some point. The reason I'm not sure if this is
a good idea is that one would have to wait for the reconnection attempt
to get the headset working after making it accessible. Therefore, it may
well be a good idea to just have to run the daemon manually when one
knows that the headset is accessible. However, in this case, the daemon
should at least terminate if it looses the RFCOMM connection to the
headset. I don't know if it's possible to detect if the RFCOMM
connection is lost, though. Comments are appreciated.

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
