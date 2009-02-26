Return-Path: <cyrus@holtmann.org>
Subject: Re: Issues in PANU
From: Marcel Holtmann <marcel@holtmann.org>
To: Chan-Yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <002401c99813$685521a0$38ff64e0$%park@samsung.com>
References: <498EB082.7040708@xyzw.org>
	 <1234113019.5355.18.camel@californication> <498F7C4E.4040305@xyzw.org>
	 <1234183143.4705.11.camel@californication> <49A2A2D4.2020904@xyzw.org>
	 <1235556025.24169.17.camel@localhost.localdomain>
	 <002401c99813$685521a0$38ff64e0$%park@samsung.com>
Content-Type: text/plain
Date: Thu, 26 Feb 2009 17:03:22 +0100
Message-Id: <1235664202.27004.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I have been working with PANU profile contained in BlueZ 4.30.
> 
> Whenever I try to connect NAP,I see the following message,
> "
> pan1 connected
> pan1 disconnected."

the pan1 suppose to be the bridge interface bluetoothd tries to connect
all its bnepX interface too.

> As you may know, the first line message is located in bnep_connect_cb(). and
> the second message is in bnecp_watchdog_cb().
> 
> As I inspect the condition value "GIOCondition cond" in bnep_watchdog_cb(),
> there is only "G_IO_ERR", and the others bits are all clean. 
> And I try to analyze error packet, but I couldn't do that.
> 
> I don't know why this problem happens.
> 
> If you're already experienced this, it'll be very thankful to give me a
> piece of advice?
> 
> 
> And I would like to ask
>  "Does BlueZ support both PANU and NAP officially?"
> As I see on the BlueZ wiki, it supports only PANU.

Yes, PANU and NAP are working. So does GN.

Regards

Marcel


