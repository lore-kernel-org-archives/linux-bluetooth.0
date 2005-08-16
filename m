Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43022E86.7080909@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Headset reconnection
References: <1124215347.21719.31.camel@pc7.dolda2000.com>
In-Reply-To: <1124215347.21719.31.camel@pc7.dolda2000.com>
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
Date: Tue, 16 Aug 2005 12:20:54 -0600

Fredrik,

You can get pdfs from bluetooth.org. The relevant ones are 6_headset.pdf 
and "HFP Spec Version 1_0.pdf"

Most headsets attempt to make the rfcomm connection to the last-used 
handset (or only handset if they only keep one pairing) on power-up. The 
stereo headsets tend to wait until the first click of the answer button.

I don't think we are doing the device class or sdp stuff to even make 
the headset aware that it can make this connection. On top of that, we 
need to be listening for connections.

a2recv listens for connections, but it may not be the clearest example. 
the way a2recv gets run is like this:

  # add a2dp to the class bitmap (I don't know which bit(s) it is)
  hciconfig hci0 class 0x200404
  # advertise through sdp
  sdptool add A2SNK
  ./a2recv

The way sdptool gets invoked there, A2SNK is advertised on the standard 
channel. You could also add --channel to change that.

Brad

Fredrik Tolf wrote:
> Hi!
> 
> I'm wondering about how BT headsets and mobile phones usually work
> together, in hope of implementing automatic connection in btsco.
> 
> Normally, it seems that a mobile phone and a headset manage to keep
> their link, even across "reboots" and other disconnections. Does a phone
> periodically scan for headsets that it knows, or does the headset
> somehow try to automatically reconnect to the phone under certain
> circumstances, or is it something completely different?
> 
> Can anyone tell me where to find info on this?
> 
> Fredrik Tolf
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
