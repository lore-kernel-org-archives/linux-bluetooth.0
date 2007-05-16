Return-Path: <davem@davemloft.net>
Date: Wed, 16 May 2007 16:16:09 -0700 (PDT)
Message-Id: <20070516.161609.108116976.davem@davemloft.net>
To: jikos@jikos.cz
Cc: satyam.sharma@gmail.com, marcel@holtmann.org, gregkh@suse.de,
        jeremy@goop.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
        clg@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.21-rc7: BUG: sleeping function called from invalid context
 at net/core/sock.c:1523
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0705170102290.13706@twin.jikos.cz>
References: <1179317775.10069.77.camel@violet>
	<Pine.LNX.4.64.0705161418250.25986@twin.jikos.cz>
	<Pine.LNX.4.64.0705170102290.13706@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

From: Jiri Kosina <jikos@jikos.cz>
Date: Thu, 17 May 2007 01:03:55 +0200 (CEST)

> On Wed, 16 May 2007, Jiri Kosina wrote:
> 
> > > since Jiri has a good test case for it, I leave it to him for testing.
> > > If he confirms that this fixes the locking issues, then this is
> > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > I will verify later this evening and will let you know. I am however 
> > pretty convinced now that this is the right fix.
> 
> Satyam,
> 
> I have just verified that this locking scheme is indeed correct. So you 
> can add
> 
> 	Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> if you wish to, and submit the patch to Andrew.

I guess I don't get sent networking patches any more?
:-)
