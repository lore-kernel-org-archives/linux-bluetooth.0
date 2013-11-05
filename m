Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 19:44:31 +0100
From: Stevie Trujillo <stevie.trujillo@gmail.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: marcel@holtmann.org, tedd.an@intel.com, linux-bluetooth@vger.kernel.org
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
Message-ID: <20131105194431.54fba8fb@localhost>
In-Reply-To: <527858A5.2080801@canonical.com>
References: <526F8804.9060906@canonical.com>
	<A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org>
	<52707428.9070908@canonical.com>
	<6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org>
	<5271EAA2.1030705@canonical.com>
	<D0B840E3-36C4-4751-A757-1ADDAC0707B9@holtmann.org>
	<5273147E.4040004@canonical.com>
	<C3BBD7E9-6D91-430E-96DF-2D4885F89DCC@holtmann.org>
	<527371D4.1010305@canonical.com>
	<9DFD9618-158E-41C4-8183-134A3FC4E61F@holtmann.org>
	<527737C7.40208@canonical.com>
	<20131104141539.772e1636@localhost>
	<527858A5.2080801@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 05 Nov 2013 10:32:05 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> Thanks for your input, I don't know the answer of your question, but
> at least the camera works well on the EHCI bus, and camera transfers
> the ISO packets over EHCI bus.

Hello again! Have you tried comparing usbmon output (I used Wireshark)
when running on EHCI and XHCI? My bluetooth card is inside the
computer, so I'm only able to do EHCI.

I see 1 ISO come in right after the SCO thing opens. It has some
error stuff inside (ENOSPC). No idea how it is supposed to behave,
since I can't compare with a good one.

Sorry if this is a stupid idea :P
