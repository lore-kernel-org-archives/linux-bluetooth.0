Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Apr 2014 14:13:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <keybuk@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BUG: l2cap and rfcomm bind with 0 psm or channel no longer
 allocate
Message-ID: <20140402111346.GA3770@t440s.lan>
References: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
 <CAHZ1yCmTzSOHDQ20szZucMrmYLvKRMpWkaLXBtvJ519EU8pBWg@mail.gmail.com>
 <20140402052134.GA27831@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140402052134.GA27831@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 02, 2014, Johan Hedberg wrote:
> On Tue, Apr 01, 2014, Scott James Remnant wrote:
> > b783fbc Bluetooth: Refuse peer L2CAP address reading when not connected
> > 35364c9 Bluetooth: Refuse peer RFCOMM address reading when not connected
> > 
> > The reason these break things is that they limit peer address checking
> > to connected sockets, btio's get_peers() function is calling both
> > getsockname() and getpeername(), bailing out if either fails, before
> > checking what option is being checked for.
> > 
> > Smells more like a bluetoothd fix, but I don't like the idea of
> > earlier versions of bluetoothd breaking on newer kernels.
> 
> Indeed. If not a bug it's at the very least bad design of BtIO (which
> I'm to blame of) and now we're stuck suffering the results from that
> since we can't really have the kernel break user space in this way.
> 
> We can (and probably should) fix this BtIO behavior, but at the same
> time I think these checks must unfortunately be removed from the kernel
> side before 3.15 goes out.

FWIW, for the user space side this should now be fixed. It could use a
bit more testing though, however at least with our test-profile script
the RFCOMM channel auto-allocation and resulting SDP record seems to be
fine.

Johan
