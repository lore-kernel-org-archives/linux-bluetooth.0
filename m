Return-Path: <steve.crane@rococosoft.com>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Stephen Crane <steve.crane@rococosoft.com>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C01@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C01@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099065198.28599.57.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 16:53:18 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Abhi,

On Fri, 2004-10-29 at 16:35, Bhatt Abhi-ABHATT wrote:

> Sorry for the confusion but I wasn't referring to user space at all. I was thinking of having the rfcomm service level security implemented in almost the same way as the l2cap service level security(incoming connection). The service level security options could be set using setsockopt(..) in rfcomm. This in turn could be used to set the service level settings for the l2cap socket it uses. I can draw a sequence diagram(function calls) to show how i
> picture the design. I'll do that.

I think that from the user-space's point of view, the interface should
be identical. (In fact I think this is already supported, just not
acted-upon: you do setsockopt(sock, SOL_RFCOMM, ...).)

> > > Also, currently there is no service level security in l2cap for 
> > > outgoing connections. I would like to know if someone has already 
> > > taken a stab at it and if this should be part of bluez in the 
> > > future.
> 
> > > I've had a look at this recently. If I get time I will have a go at  
> > > implementing it.
> 
> Steve, I would be interested to know how you intend to implement it.

I will need to revisit my notes. It's been a while and I've forgotten
:-(

> Plus JSR-82 requires that service level security should be possible for
> outgoing connections. So for anyone trying to implement JSR-82 and using
> bluez, it is needed.

This is a bit strong: p42 of the JSR-82 spec states that "Not all
Bluetooth systems support authentication [...]". Thus you _can_ conform
to JSR-82 without this. However it's nice to have :-)

> Regards
> Abhi

Cheers,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
