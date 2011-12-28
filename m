Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: =?utf-8?q?Tom=C3=A1=C5=A1_Janou=C5=A1ek?= <tomi@nomi.cz>
Subject: Re: [REGRESSION] resume takes 10s longer due to e1b6eb3 (Bluetooth: Increase HCI reset timeout ...)
Date: Wed, 28 Dec 2011 20:21:04 +0100
Cc: Gustavo Padovan <padovan@profusion.mobi>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
References: <20111118184017.GA5052@nomi.cz> <201112232143.20937.szymon@janc.net.pl> <20111223204849.GA23712@nomi.cz>
In-Reply-To: <20111223204849.GA23712@nomi.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201112282021.04658.szymon@janc.net.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomáš,

> Tell me what you need and how can I get that, and I'm all yours.

We need to figure out why command complete event to reset command is not 
received and we get timeout for your bt chip.

So first please provide kernel debug logs and hcidump while resuming (with 
timeout set to 10s). Also for kernel logs please make sure you have kernel 
prints timestamps enabled.

hcidump -t

kernel:
echo "module bluetooth +pf" >/sys/kernel/debug/dynamic_debug/control
echo "module btusb +pf" >/sys/kernel/debug/dynamic_debug/control

-- 
Szymon K. Janc
szymon@janc.net.pl // GG: 1383435
