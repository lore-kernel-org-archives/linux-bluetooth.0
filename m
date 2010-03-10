Return-Path: <cyrus@holtmann.org>
Message-ID: <e8dc052360dd27d2ac7460d359e7645c.squirrel@www.codeaurora.org>
Date: Tue, 9 Mar 2010 23:06:15 -0600 (CST)
Subject: AMP Key Management Simplification?
From: "Tim Monahan-Mitchell" <tmonahan@codeaurora.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ mailing list" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

A discussion was missing from our original posting ("QuIC's AMP + eL2CAP
Technical Plans"), regarding AMP Keys.

We would like to defer the ability to work with more than one AMP device
type initially, since doing so would necessitate having to persist the
Dedicated AMP Keys for each AMP device type. Is this approach acceptable?

Limiting the initial design to a single AMP device, the Dedicated AMP key
can be generated any time from the associated link key.

I can provide more details as to why if needed (refer to 8.1 & 8.2 in the
Core spec).

Thanks,
Tim Monahan-Mitchell
Qualcomm Innovation Center, Inc.,
A member of the Code Aurora Forum

