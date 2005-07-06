Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42CBF7A6.7090708@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Moving over to GCC 4.0
References: <1120649879.8836.5.camel@pegasus>
In-Reply-To: <1120649879.8836.5.camel@pegasus>
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
Date: Wed, 06 Jul 2005 09:24:22 -0600

just FYI everybody... sourceforge seems to have broken anonymous cvs 
(both bluez and bluetooth-alsa are affected)

$ cvs update -d
cvs [update aborted]: unrecognized auth response from cvs.bluez.org: cvs 
pserver: cannot read /cvsroot/bluez/CVSROOT/config: Input/output error

Marcel Holtmann wrote:
> Hi Folks,
> 
> since Debian Etch now also switched to GCC 4.0 as default compiler, it
> is time to address all GCC 4.0 problems in the BlueZ source code. I
> started two days ago with fixing most of its crazy compiler warnings.
> The GCC 4.0 is really picky with the signedness and so I moved over to
> explicit types like uint8_t, uint16_t and uint32_t where possible. I now
> hope that I haven't introduced any signedness bugs. Please start testing
> the CVS versions of libs and utils.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
