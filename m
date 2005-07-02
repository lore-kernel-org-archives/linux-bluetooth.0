Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42C70688.9050407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] emporia/mega-Headset and btsco problems
References: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>
In-Reply-To: <20050702172632.3d3b3dcd.andy.boehler@gmx.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sat, 02 Jul 2005 15:26:32 -0600

Andreas,

This is an unintended consequence of a change a few months ago to make 
the sco connection fire up only on demand.

One thing we have needed to do for a long time that would help this is 
to rebuild the rfcomm connection when it goes bad (or even make it 
happen on demand). With other headsets, the rfcomm connection only goes 
bad if the headset goes out of range. Holding the rfcomm connection open 
isn't great anyway because I think it prevents a laptop from suspending.

As far as I can tell, phones hold the rfcomm connection open and only 
fire up sco on demand. I wonder if they have to accommodate this too...

Brad

Andreas Böhler wrote:
> Hi!
> 
> I recently purchased a Mega BT-Headset and fetched, compiled and installed btsco from bluetooth-alsa.sf.net. 
> Pairing works fine and sending and receiving audio from and to the headset also works - for a while. 
> My problem is, that the headset disconnects after a very short time if no audio is transmitted!
> I think that this is the same problem as with the Jabra BT-110: "Jabra BT110 (will turn off very soon after the last audio packets have been transmitted and btsco will quit with "RFCOMM channel lost")" -> quote from bluetooth-alsa.sf.net main page.
> I'm wondering if someone has solved this problem? Isn't it possible that btsco simply reconnects to the headset? Or that it transmits empty or quiet audio-frames just to keep the connection alive?
> I tried what is done using Windows: When you connect the headset, it rings as if the phone was ringing and you have to pick it up (headset-button), then the connection is established. I wonder if this would also work under Linux? Or is this the implementation of the Hands-Free profile and not the Headset-Profile?
> 
> Any help is appreciated, 
> 
> thanks,
> 
> Andreas Böhler
> 
> PS: I'm using Linux 2.6.12, custom compilation, D-Link DBT-120 (or Digitus DN-3008), SoL-Linux 18.00, BlueZ-stack and Mega BTHS-6023-F (manufacturer is Emporia, www.emporia.at)
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
