Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Manuel Harnisch <mh@intellinetservices.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP btsco support
References: <200503261356.57766.mh@intellinetservices.net> <1111894787.9195.213.camel@pegasus>
In-Reply-To: <1111894787.9195.213.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503262334.35244.mh@intellinetservices.net>
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
Date: Sat, 26 Mar 2005 23:34:35 -0500

Marcel,

If I wouldn't be a bit short on cash right now, I'd donate a pair of HP 
headphones to the project. They are only about $99 here in the US... but I 
really can't afford that right now... maybe in a couple of weeks...

Manuel

On Saturday 26 March 2005 10:39 pm, Marcel Holtmann wrote:
> Hi Manuel,
>
> > I have a pair of HP bluetooth headphones and I've done some testing with
> > them together with the btsco/a2play project. The bottom line is that they
> > do work, I've got stereo sound, but there is a problem with the timing.
> > It is significantly related to how well the bluetooth reception is. I get
> > the best results around an lq of 207 (hcitool lq BDDR).
> > I've had contact with Brad Midgley before and he recommend to post this
> > issue here. I am not a coder, but I've some basic understanding of C/C++,
> > that's about it. I wouldn't even know where to look for the timing
> > related code. I'd like to offer to test any new code.
>
> the goal will be to go for a direct ALSA plugin, but my Aiptek is not
> really conforming to the A2DP specification. This means that I don't
> have any headphone to really work with and thus I can't solve this
> issue.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
Manuel Harnisch, IntellinetServices
Systems Administrator &
Web Developer

Mobile: (267) 237-7080
Email: mh@intellinetservices.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
