Return-Path: <mcq@cacr.caltech.edu>
Date: Sun, 7 Mar 2004 16:48:11 -0800
From: John McCorquodale <mcq@cacr.caltech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: John McCorquodale <mcq@cacr.caltech.edu>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket G card newbie Q
Message-ID: <20040308004811.GA19145@viz.cacr.caltech.edu>
References: <20040307214224.GB18481@viz.cacr.caltech.edu> <1078704901.15279.6.camel@pegasus> <20040308002100.GA19049@viz.cacr.caltech.edu> <1078705579.15279.18.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1078705579.15279.18.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

> May this is the problem with some serial cards and 2.6. Try 2.4 instead.

Progress.  2.4.25 produces different behavior:

First time loading it says:
bcsp_recv: Out-of-order packet arrived, expected 1 got 0

Second time loading it says:
Unknown device type or id

In 2.4.20, it always says "Unknown device type or id".

So two questions:

  1) Is there maybe a new G card device id out there, or should I be using
     some other bluez than that which ships with 2.4.25?

  2) Is there a patch for the 2.6 serial problem?

Thanks,

-mcq
