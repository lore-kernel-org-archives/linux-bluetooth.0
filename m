Return-Path: <cyrus@holtmann.org>
Message-ID: <1335004527.16897.337.camel@aeonflux>
Subject: Re: PTS / linkkey issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 21 Apr 2012 12:35:27 +0200
In-Reply-To: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
References: <CAB7rCTjRzTZP6TDgsrWvFxE8zuFuYDBQdMnjyvnM4p6Cw=ro2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> I'm having a somewhat relate issue to Vishal AGARWAL [1].  The trouble
> I have is that the PTS system is requesting auth type 0, and Bluez
> happily obliges.  This leaves the PTS device as temporary, and BlueZ
> then deletes this device after the end of the connection.  This
> prevents me from being able to pass TP/OOR/BV-02-I: [HF reconnects to
> AG].  The code is designed to periodically reconnect to the AG after
> it detects a link timeout.  But, if BlueZ has deleted the device, I
> don't do that.  This also somewhat applies to the A2DP test cases, as
> my device must be left in pairing mode in order for the tests to pass.
> 
> So, my question to people who have used PTS, is there a way to get the
> PTS to perform a pairing that is not 0x00 MITM Protection Not Required
> – No Bonding. Numeric comparison with automatic accept allowed?  I'm
> using an older kernel that doesn't have the mgmt interface (2.6.33
> with some features/fixes backported from newer kernels) but am using
> the latest BlueZ from git (at least of a month ago or so).  But even
> so, the proposal of keeping the linkkey around for the ACL session
> would be useless, I think, because the intent is to have a link
> timeout event.

can you quickly check if for some weird reason the PTS uses debug keys
or if you enabled debug keys within BlueZ.

We treat debug keys even worse than no bonding. Unless you set DebugKeys
in /etc/bluetooth/main.conf they are thrown out right away. However be
really careful here. That option is only for debugging. You should never
ever leave that on in a production device. You would make your device
vulnerable like no tomorrow.

Regards

Marcel


