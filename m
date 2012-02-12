Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: Tomas Janousek <tomi@nomi.cz>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth: Increase HCI reset timeout ...)
Date: Sun, 12 Feb 2012 17:49:31 +0100
Cc: Gustavo Padovan <padovan@profusion.mobi>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
References: <20111118184017.GA5052@nomi.cz> <201112282021.04658.szymon@janc.net.pl> <20120212113743.GA14271@notes.lisk.in>
In-Reply-To: <20120212113743.GA14271@notes.lisk.in>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Message-Id: <201202121749.31792.szymon@janc.net.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I'm attaching dmesg and hcidump output.
> 
> I'm sorry for the delay, I did not have a kernel with dynamic_debug enabled
> and I didn't have time to reboot and lose my open terminals. Now I updated
> to today's kernel snapshot and enabled debugging, so as long as I don't
> have to reboot, I should be able to react quickly. :-)

Can you try with this patch applied: 
http://git.kernel.org/?p=linux/kernel/git/jh/bluetooth-
next.git;a=commit;h=30a824d82726f4d10105e5f8c1afa7ebcda17523
?

-- 
Szymon K. Janc
szymon@janc.net.pl
