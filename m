Return-Path: <cyrus@holtmann.org>
Subject: Re: clock offset
From: Marcel Holtmann <marcel@holtmann.org>
To: David Thornton <david@villagepublishing.com.au>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49655A2A.1020709@villagepublishing.com.au>
References: <49655A2A.1020709@villagepublishing.com.au>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:30:47 +0100
Message-Id: <1232292647.5095.27.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I know this is a general question, not related to bluez (but to 
> blutooth) and if I should post it here, please - shout me down.
> 
> its about the clock offset field in an HCI packet that queries another 
> device. If i set the valid flag to 0, does that mean it disregards the 
> clock offset - and i could set  the whole field to zero?
> 
> I dont want it to be light speed and optimized, just work (for now...)

simple answer is yes. However some chips optimize this by themself in
the link manager anyway.

Regards

Marcel


