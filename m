Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099497364.3261.64.camel@baroque.rococosoft.com>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
	 <1099497364.3261.64.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1099498137.6330.29.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 03 Nov 2004 17:08:57 +0100

Hi Steve,

> > thanks for testing and what do you think, should I put this feature into
> > the next stable kernel?
> 
> Yes: definitely!

does anyone tested this on a SMP system, a 64 bit box or big endian
machine?

> > Another question is what should we do when the encryption on a link with
> > RFCOMM_ENCRYPT is switched off? At the moment L2CAP keeps works, but in
> > the RFCOMM layer I drop the connection by sending DM.
> 
> Yeah I thought I saw something like this happen. I don't think it is 
> correct behaviour. My reasoning would go something like this:
> 
> * If encryption on a link is switched off at the HCI level, _all_ of the
> connections (L2CAP and RFComm) which required it should be closed
> shouldn't they? 
> 
> * Conversely, encryption should be automatically turned off on a link
> when the last connection which required encryption is closed.
> 
> * Owners of a connection should be able to indicate that they're no
> longer interested in encryption by an ioctl on the L2CAP or RFComm
> socket.
> 
> * Connections which were created without the encryption requirement
> should be able to ask for it by a similar ioctl.
> 
> I imagine this behaviour would be required only very rarely but it seems
> the most intuitive to me. What do you think?

Actually I have no real meaning about it a the moment. There are pros
and cons and I like to follow some written specification or erratum. Is
there something that tells us exactly what to do in these cases?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
