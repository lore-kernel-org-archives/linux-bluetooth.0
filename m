Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid on ppc
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4056493B.5040000@handgranat.org>
References: <20040307221349.GA1930@stag.mark-and-erika.com>
	 <1078704798.15279.3.camel@pegasus>
	 <20040308054000.GB1930@stag.mark-and-erika.com>
	 <405638DD.2080000@handgranat.org> <1079393759.3307.46.camel@pegasus>
	 <4056493B.5040000@handgranat.org>
Content-Type: text/plain
Message-Id: <1079423312.3307.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 08:48:32 +0100

Hi Sunnan,

> Thanks for correcting my misinformation.
> Could you please tell me where this suspected non-big-endian safe code 
> is? (Which files and functions, etc?)

I think the problems are in libs2/lib/sdp.c or libs2/lib/sdp_data.c.

> As I said, I've gotten the other bthid to work for repeating intervals a 
> few seconds long. I guess it could still be a big endian problem, but it 
> doesn't crash, it's just unable to read SDP (I don't even know what SDP 
> is! Embarassing, I'm going to read up on that) sometimes.

There is a sdptest program under libs2/test and you can play with.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
