Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101206212326.GI883@vigoh>
References: <1290763257-12382-1-git-send-email-pavan_savoy@ti.com>
	<20101130154654.GE5919@vigoh>
	<AANLkTiktDkjFH=aGbu3f+mkVUgmFDwB6xLW3e1VNXKtz@mail.gmail.com>
	<20101206212326.GI883@vigoh>
Date: Mon, 6 Dec 2010 22:35:41 +0100
Message-ID: <AANLkTimJiHhkwb-0PQqc6n3wJwx2WPterQqMCXqzce8z@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: btwilink driver
From: Vitaly Wool <vitalywool@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Pavan Savoy <pavan_savoy@ti.com>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Dec 6, 2010 at 10:23 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:

> Can't you differentiate Bluetooth data in a generic way, withou looking if it
> is ACL, SCO or HCI EVENT? That done, you can just accumulate in a buffer all
> the Bluetooth data you received in that stream then send it to Bluetooth
> driver after finish that stream processing.

I'm afraid he can't do this because he needs to route events to the
appropriate entity (BT/FM/GPS). I'm not sure how it can be done
without analyzing the incoming packet.

Thanks,
   Vitaly
