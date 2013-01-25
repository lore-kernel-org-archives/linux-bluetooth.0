Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 11:55:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 0/6] LE Connection Establishment fixes
Message-ID: <20130125095544.GA3638@x220>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
 <20130125071215.GC17746@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130125071215.GC17746@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jan 25, 2013, Johan Hedberg wrote:
> On Fri, Jan 25, 2013, Vinicius Costa Gomes wrote:
> > The only problem with this aproach that I found while testing is the
> > problem exposed on the message of commit 5/6: If the remote device is
> > out of range during pairing any connection attempt will fail until the
> > Connection Complete event comes (with an error). This is the reason
> > that we put the devices in the connect list before pairing.
> > 
> > Is this reason enough to have the device put in the connect list
> > during pairing?
> 
> I don't think so. The mgmt_pair_device should have a timeout for LE
> devices on the kernel side, but since this is not the case with current
> kernel versions we'll need a workaround in user space. I.e. instead of
> using scanning (I assume that's what putting it on the connect list will
> do) you should just use a simple timeout (g_timeout_add_seconds) and
> call mgmt_cancel_pair_device if it expires.

I realized that you were mainly talking about the socket timeout and not
mgmt_pair_device timeout. The socket does have a proper kernel side
timeout while mgmt_pair_device doesn't (yet) so the latter needs
protecting (checking for connection status before deciding what to do is
racy so the protection needs to be there).

Anyway, I went ahead and fixed the pairing part and that's all I have
time for today. If there's still something needing fixing with the
reconnections feel free to send further patches.

Johan
