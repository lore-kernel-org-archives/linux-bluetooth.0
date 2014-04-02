Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Apr 2014 08:21:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BUG: l2cap and rfcomm bind with 0 psm or channel no longer
 allocate
Message-ID: <20140402052134.GA27831@t440s.P-661HNU-F1>
References: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
 <CAHZ1yCmTzSOHDQ20szZucMrmYLvKRMpWkaLXBtvJ519EU8pBWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHZ1yCmTzSOHDQ20szZucMrmYLvKRMpWkaLXBtvJ519EU8pBWg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Tue, Apr 01, 2014, Scott James Remnant wrote:
> b783fbc Bluetooth: Refuse peer L2CAP address reading when not connected
> 35364c9 Bluetooth: Refuse peer RFCOMM address reading when not connected
> 
> The reason these break things is that they limit peer address checking
> to connected sockets, btio's get_peers() function is calling both
> getsockname() and getpeername(), bailing out if either fails, before
> checking what option is being checked for.
> 
> Smells more like a bluetoothd fix, but I don't like the idea of
> earlier versions of bluetoothd breaking on newer kernels.

Indeed. If not a bug it's at the very least bad design of BtIO (which
I'm to blame of) and now we're stuck suffering the results from that
since we can't really have the kernel break user space in this way.

We can (and probably should) fix this BtIO behavior, but at the same
time I think these checks must unfortunately be removed from the kernel
side before 3.15 goes out.

Johan
