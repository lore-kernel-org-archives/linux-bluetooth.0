Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099496238.6330.2.camel@notepaq>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
Content-Type: text/plain
Message-Id: <1099497364.3261.64.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 15:56:04 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Wed, 2004-11-03 at 15:37, Marcel Holtmann wrote:
> thanks for testing and what do you think, should I put this feature into
> the next stable kernel?

Yes: definitely!

> Another question is what should we do when the encryption on a link with
> RFCOMM_ENCRYPT is switched off? At the moment L2CAP keeps works, but in
> the RFCOMM layer I drop the connection by sending DM.

Yeah I thought I saw something like this happen. I don't think it is 
correct behaviour. My reasoning would go something like this:

* If encryption on a link is switched off at the HCI level, _all_ of the
connections (L2CAP and RFComm) which required it should be closed
shouldn't they? 

* Conversely, encryption should be automatically turned off on a link
when the last connection which required encryption is closed.

* Owners of a connection should be able to indicate that they're no
longer interested in encryption by an ioctl on the L2CAP or RFComm
socket.

* Connections which were created without the encryption requirement
should be able to ask for it by a similar ioctl.

I imagine this behaviour would be required only very rarely but it seems
the most intuitive to me. What do you think?

Regards,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
