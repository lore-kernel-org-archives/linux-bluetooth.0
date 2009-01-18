Return-Path: <cyrus@holtmann.org>
Subject: Re: Questions on connecting BlueZ/SBC with Ekiga
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian Hoene <hoene@uni-tuebingen.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <016701c97976$e75578d0$b6006a70$@de>
References: <016701c97976$e75578d0$b6006a70$@de>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:05:06 +0100
Message-Id: <1232291106.5095.6.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> I have a question on how to use A2DP and SBC for streaming of audio over the
> Internet.
> 
> How would you implement an interface between Ekiga and BlueZ? The
> requirements are
> 1 SBC frames from Ekiga
> 1.1 Shall be played via an A2DP device.
> 1.2 Shall be played via the sound card of the PC.

can you use GStreamer here since that includes the SBC encoder and
decoder as elements. You can construct the pipeline as you like.

Meaning that Ekiga would be a GStreamer source. Of course you would have
to write that specific source element.

> 2. SBC frame going to Ekiga
> 2.1 Recorded from an A2DP device
> 2.2 recorded by the PC's sound card.

Having Ekiga as a GStreamer sink sounds like a good idea.

> Due to legal reason we must use the BlueZ and are not allowed to include SBC
> into Ekiga.

What kind of legal reasons are you talking about here. The SBC
implementation is released under LGPL. Worst case issue here is that you
actually build an independent library out of it and just link it
dynamically. We were planning to do so anyway, but currently that is not
really sufficient for us. It would just create a maintenance overhead.

Regards

Marcel


