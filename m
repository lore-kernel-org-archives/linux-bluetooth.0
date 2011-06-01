Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 1 Jun 2011 17:06:53 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: Re: Binary PIN Support
Message-ID: <20110601200653.GG2564@joana>
References: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
 <BANLkTikmin21C5ZRN7PsZcfo1kzmGYvbFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTikmin21C5ZRN7PsZcfo1kzmGYvbFQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2011-06-01 11:32:33 -0400]:

> Hi David,
> 
> On Wed, Jun 1, 2011 at 10:47 AM, David Herrmann
> <dh.herrmann@googlemail.com> wrote:
> > Any comments or other ideas?
> 
> What about a "BinaryPIN" adapter property (default: False) that when
> set to True treats the PIN data as binary stream and not as string? It
> shall be False by default so to not break backwards compatibility.

It's not on the adapter, it may have others devices paired with non-binary
pincode.
Maybe we should signal this BinaryPIN property on the DeviceFound signal,
seems like a good place for this.

-- 
Gustavo F. Padovan
http://profusion.mobi
