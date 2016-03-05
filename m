Return-Path: <tore@fud.no>
Date: Sat, 5 Mar 2016 10:09:00 +0100
From: Tore Anderson <tore@fud.no>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: Bluetooth mouse not working after resume since commit
 2ff1389
Message-ID: <20160305100900.0b097304@envy.w5.y.home>
In-Reply-To: <20160304065406.GA17899@t440s.P-661HNU-F1>
References: <20160220181259.1e28f8da@envy.w5.y.home>
	<20160220182339.GA1648@t440s.P-661HNU-F1>
	<20160220182919.GA2620@t440s.P-661HNU-F1>
	<20160220213028.35760428@envy.w5.y.home>
	<20160221070226.GA12780@t440s.P-661HNU-F1>
	<20160221121322.6a19b1d4@envy.w5.y.home>
	<20160303085116.0567712b@echo.ms.redpill-linpro.com>
	<20160303084229.GA15622@t440s.ger.corp.intel.com>
	<20160303214419.6ac7558a@envy.w5.y.home>
	<20160304065406.GA17899@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> It's a relief to hear that the issue seems to be fixed, but it would
> indeed be good to get to the bottom of this and understand what
> exactly fixed it, since I can't right now remember any recent patches
> that would have influenced this behavior (who knows - maybe it's
> something external to the Bluetooth subsystem).

It got fixed by:

commit d82142a8b1338e6a4339920863423379c27b0b16
Author: Wei-Ning Huang <wnhuang@chromium.org>
Date:   Mon Feb 15 17:09:51 2016 +0800

    Bluetooth: hci_core: cancel power off delayed work properly

    When the HCI_AUTO_OFF flag is cleared, the power_off delayed work need
    to be cancel or HCI will be powered off even if it's managed.

    Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Tore
