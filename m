Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Feb 2014 21:48:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 10/10] Bluetooth: Wait for SMP key distribution
 completion when pairing
Message-ID: <20140218194804.GA9146@x220.p-661hnu-f1>
References: <1392736479-8808-11-git-send-email-johan.hedberg@gmail.com>
 <1392738285-12143-1-git-send-email-johan.hedberg@gmail.com>
 <64342F55-7059-49C3-92FF-7ED23AB904D1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <64342F55-7059-49C3-92FF-7ED23AB904D1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 18, 2014, Marcel Holtmann wrote:
> > +	cmd = find_pairing(conn);
> > +	if (!cmd)
> > +		BT_DBG("Unable to find a pending command”);
> 
> why do we bother with the debug print here?
> 
> > +	else
> > +		pairing_complete(cmd, status);
> 
> I would just do this:
> 
> 	if (cmd)
> 		pairing_complete(cmd, status);
> 
> Unless you have future patches that do more work here.

The main reason was to get some idea how frequently this function gets
called unnecessarily, but you're right in that it's kind of useless.
I've removed it in my latest set.

Johan
