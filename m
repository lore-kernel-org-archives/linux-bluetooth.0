Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A93A21.1090809@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Elimination of pow() in SBC code
References: <1101599506.18467.6.camel@pegasus>
In-Reply-To: <1101599506.18467.6.camel@pegasus>
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
Date: Sat, 27 Nov 2004 19:38:25 -0700

guys

that's a good idea to break the need for libm and for another 
int->float->int conversion

> 	scalefactor[ch][sb] = pow(2.0, (frame->scale_factor[ch][sb] + 1));
> 
> So what is the range of scale_factor[ch][sb]. From a quick testing a saw
> that it ranges from 0 - 15. Is this always true? If yes, then I would
> use a pre-calculated array for 2^x.

or like

  scalefactor[ch][sb] = 4 << frame->scale_factor[ch][sb];

the compiler doesn't know about the limited range of scale_factor so it 
may actually generate a loop here.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
