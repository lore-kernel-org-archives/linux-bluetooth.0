Return-Path: <jt@bougret.hpl.hp.com>
Date: Fri, 13 Aug 2004 16:53:33 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: Re: CSR firmware question...
Message-ID: <20040813235333.GA5860@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040813002514.GA21388@bougret.hpl.hp.com> <1092385877.28711.185.camel@pegasus> <20040813163736.GC22763@bougret.hpl.hp.com> <1092416234.28711.256.camel@pegasus> <20040813223412.GA3158@bougret.hpl.hp.com> <1092440127.4501.73.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092440127.4501.73.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, Aug 14, 2004 at 01:35:27AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> your firmware update must be successful, because this looks like a
> dongle with HCI 18.1 firmware in HID mode. Use hid2hci. It must work.

	Found the reason. Under 2.6.X, hid2hci doesn't work. On the
other hand, works fine in 2.4.X. And of course need to be done every
time I plug the dongle.
	Hmm...

> Regards
> 
> Marcel

	Jean
