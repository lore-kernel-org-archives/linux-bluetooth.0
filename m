Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
References: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
Date: Tue, 1 Apr 2014 18:01:16 -0700
Message-ID: <CAHZ1yCmTzSOHDQ20szZucMrmYLvKRMpWkaLXBtvJ519EU8pBWg@mail.gmail.com>
Subject: Re: BUG: l2cap and rfcomm bind with 0 psm or channel no longer allocate
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Culprit commits are:

b783fbc Bluetooth: Refuse peer L2CAP address reading when not connected
35364c9 Bluetooth: Refuse peer RFCOMM address reading when not connected

The reason these break things is that they limit peer address checking
to connected sockets, btio's get_peers() function is calling both
getsockname() and getpeername(), bailing out if either fails, before
checking what option is being checked for.


Smells more like a bluetoothd fix, but I don't like the idea of
earlier versions of bluetoothd breaking on newer kernels.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
