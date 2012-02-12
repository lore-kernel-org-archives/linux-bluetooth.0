Return-Path: <cyrus@holtmann.org>
Date: Sun, 12 Feb 2012 18:15:14 +0100
From: =?utf-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>
To: Szymon Janc <szymon@janc.net.pl>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linux PM mailing list <linux-pm@vger.kernel.org>,
	"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3
	(Bluetooth: Increase HCI reset timeout ...)
Message-ID: <20120212171514.GA22073@nomi.cz>
References: <20111118184017.GA5052@nomi.cz> <201112282021.04658.szymon@janc.net.pl> <20120212113743.GA14271@notes.lisk.in> <201202121749.31792.szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201202121749.31792.szymon@janc.net.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Feb 12, 2012 at 05:49:31PM +0100, Szymon Janc wrote:
> Can you try with this patch applied: 
> http://git.kernel.org/?p=linux/kernel/git/jh/bluetooth-
> next.git;a=commit;h=30a824d82726f4d10105e5f8c1afa7ebcda17523
> ?

Yes. It no longer waits 10 seconds. Bluetooth works fine both before and after
suspend/resume (just so you don't have to ask). Thanks.

-- 
Tomáš Janoušek, a.k.a. Liskni_si, http://work.lisk.in/
