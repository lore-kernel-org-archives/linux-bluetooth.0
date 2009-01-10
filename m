Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Jan 2009 14:41:19 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Inconsistencies with UUIDs in XML service descriptors
Message-ID: <20090110124119.GA20941@localhost>
References: <11f7a7550901090850x4c276806v6c3c4bfad804986f@mail.gmail.com> <11f7a7550901090852s30060e38g7c9240731d3a9a4f@mail.gmail.com> <11f7a7550901100402o790bd614ud46a613e2dce1dbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11f7a7550901100402o790bd614ud46a613e2dce1dbd@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniele,

On Sat, Jan 10, 2009, Daniele Benucci wrote:
> 2009/1/9 Daniele Benucci <d.benux@gmail.com>
> > I've noticed a strange behaviour in the last versions of Bluez (at
> > least >= 4.19) when retrieving services via the DBus method in
> > org.bluez.Device.DiscoverServices:
> 
> I compiled 4.18 from source and the result of DiscoverServices reports
> the correct UUIDs both for 16-bit and 128-bit

Looking at the difference between 4.18 and 4.19 (git diff 4.18..4.19) at
least the new sdp_copy_record implementation seems like a potential
candidate for the cause of this. Could you perhaps try to use git bisect
to determine the exact patch that causes the bug?

Johan
