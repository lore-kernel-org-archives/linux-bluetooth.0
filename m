Return-Path: <steve.crane@rococosoft.com>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099068050.10164.69.camel@pegasus>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
	 <1099061231.10164.62.camel@pegasus>
	 <1099062653.28599.47.camel@baroque.rococosoft.com>
	 <1099068050.10164.69.camel@pegasus>
Content-Type: text/plain
Message-Id: <1099310550.28599.132.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 12:02:31 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Fri, 2004-10-29 at 17:40, Marcel Holtmann wrote:
> However this also leads to a security problem, because I can scan the
> RFCOMM ports of a remote device without forcing the security mechanism.
> I only have to do the PN exchange and then disconnect. What should a
> remote device do when a PN CMD comes in for a channel without a service
> behind it?

If the spec says that authentication can only happen on receipt of SABM,
then I guess this leaves it open to port scans. 

However, does this really matter? If you want to protect _all_ services,
use security mode 3. If you're in security mode 2, it's most likely that
you can do SDP searches without performing a security procedure and
discover open channels that way.

> Sorry, I don't get the point. Why should a client care about security
> mode 2, when it want to connect to a server in security mode 1. Actually
> the server must know what services to protect and not the client. If you
> have such server running, then this is a wrong designed server from my
> point of view.

Well, for example, a client may wish to authenticate a server before
connecting to it, irrespective of the security the service wants for
itself.

> Regards
> 
> Marcel

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
