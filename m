Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix possible crash on startup
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100810130643h81e09f0qc3c9cd57602867e7@mail.gmail.com>
References: <1223766202.31961.868.camel@cookie.hadess.net>
	 <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
	 <2d5a2c100810130643h81e09f0qc3c9cd57602867e7@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-lFT93ROAvQ4LTQhMzf1m"
Date: Mon, 13 Oct 2008 15:16:51 +0100
Message-Id: <1223907411.31961.3251.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-lFT93ROAvQ4LTQhMzf1m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2008-10-13 at 10:43 -0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> I guess we can make all driver to do the discover on Connect if the
> record is not available, similar to what is done in audio.

I'm not certain whether the problem is no record, or a broken one.

This is the file causing problems, the device line that causes the crash
is the one starting with 00:1E:45:AD:F1:96. So there is data, but it
probably isn't parsed properly.

Cheers

--=-lFT93ROAvQ4LTQhMzf1m
Content-Disposition: attachment; filename="profiles"
Content-Type: text/plain; name="profiles"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

00:1E:45:AD:F1:96 00000002-0000-1000-8000-0002ee000002 00001101-0000-1000-8000-00805f9b34fb 00001103-0000-1000-8000-00805f9b34fb 00001104-0000-1000-8000-00805f9b34fb 00001105-0000-1000-8000-00805f9b34fb 00001106-0000-1000-8000-00805f9b34fb 0000110a-0000-1000-8000-00805f9b34fb 0000110c-0000-1000-8000-00805f9b34fb 0000110e-0000-1000-8000-00805f9b34fb 00001112-0000-1000-8000-00805f9b34fb 00001115-0000-1000-8000-00805f9b34fb 00001116-0000-1000-8000-00805f9b34fb 0000111f-0000-1000-8000-00805f9b34fb 00001124-0000-1000-8000-00805f9b34fb 0000112f-0000-1000-8000-00805f9b34fb 00001200-0000-1000-8000-00805f9b34fb 8e771301-0000-1000-8000-00805f9b34fb 8e771401-0000-1000-8000-00805f9b34fb
00:0A:94:C0:AB:9B 00001124-0000-1000-8000-00805f9b34fb

--=-lFT93ROAvQ4LTQhMzf1m--

