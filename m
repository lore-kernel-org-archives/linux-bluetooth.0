Return-Path: <jikos@jikos.cz>
Date: Thu, 17 May 2007 01:20:03 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: David Miller <davem@davemloft.net>
cc: satyam.sharma@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Greg KH <gregkh@suse.de>, jeremy@goop.org, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net, clg@fr.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.21-rc7: BUG: sleeping function called from invalid context
 at net/core/sock.c:1523
In-Reply-To: <20070516.161609.108116976.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0705170116260.13706@twin.jikos.cz>
References: <1179317775.10069.77.camel@violet> <Pine.LNX.4.64.0705161418250.25986@twin.jikos.cz>
 <Pine.LNX.4.64.0705170102290.13706@twin.jikos.cz> <20070516.161609.108116976.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 16 May 2007, David Miller wrote:

> > I have just verified that this locking scheme is indeed correct. So you 
> > can add
> > 
> > 	Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > 
> > if you wish to, and submit the patch to Andrew.
> I guess I don't get sent networking patches any more?
> :-)

Well, this is bluetooth-specific, but it seemed to me that Marcel wasn't 
going to send pull requests to Linus any time soon, therefore I thought 
going through akpm is a thing to do.

Honestly, I really don't care through which tree this goes in, so sorry if 
any offence was caused here :)

-- 
Jiri Kosina
