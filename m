Return-Path: <sunnan@handgranat.org>
Message-ID: <4056493B.5040000@handgranat.org>
Date: Tue, 16 Mar 2004 01:24:27 +0100
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid on ppc
References: <20040307221349.GA1930@stag.mark-and-erika.com>	 <1078704798.15279.3.camel@pegasus>	 <20040308054000.GB1930@stag.mark-and-erika.com>	 <405638DD.2080000@handgranat.org> <1079393759.3307.46.camel@pegasus>
In-Reply-To: <1079393759.3307.46.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi again, Marcel,
Marcel Holtmann wrote:
> the sdpd has nothing to do with it. It is the "new" SDP code that both
> implementations carry and I think none of it is big endian safe.

Thanks for correcting my misinformation.
Could you please tell me where this suspected non-big-endian safe code 
is? (Which files and functions, etc?)

As I said, I've gotten the other bthid to work for repeating intervals a 
few seconds long. I guess it could still be a big endian problem, but it 
doesn't crash, it's just unable to read SDP (I don't even know what SDP 
is! Embarassing, I'm going to read up on that) sometimes.

one love, sunnan
