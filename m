Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42B86FD5.8020204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Advanced Audio Distribution Profile (A2DP)
References: <C70061B183DE09419568AB2060C52A95702C9A@arion.intra.local>	 <1119374946.26772.119.camel@pegasus>  <42B8563E.9040008@xmission.com> <1119378538.26772.127.camel@pegasus>
In-Reply-To: <1119378538.26772.127.camel@pegasus>
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
Date: Tue, 21 Jun 2005 13:51:49 -0600

Marcel

>>i was hoping to get the timing problem hammered by using setitimer. 
>>unfortunately, there still seems to be some dependency on the cpu speed 
>>which is surprising to me. there's a place in the code where the time 
>>period reported by libsbc is multiplied by 87/100. that 87 has to be 
>>tweaked for different cpus :(
> 
> this is because the encoding itself takes some time. For that we need to
> encode up to 6 SBC frames in advance.

the way a2play is now, we do preencode. right now it's set so the 
encoder will get ahead by 3 packets (typically 6 frames each?). sigalarm 
fires off regularly to initiate the transmission of one packet.

as far as integer stuff, should we be doing something like a short float

struct sfloat {
  int16 mantissa;
  uint8 exponent;
}

or a fixed point 32-bit value? any idea what part of the 32 bits would 
be best to have in front and behind the decimal?

i guess i should start by having libsbc keep track of ranges of the 
different floats so we can figure out where the precision needs to be.

brad


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
