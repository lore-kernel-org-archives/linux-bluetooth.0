Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Sep 2013 16:51:18 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: atar <atar.yosef@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Can't initialize a Bluetooth antenna.
Message-ID: <20130910155118.GF1916@joana>
References: <op.w24t4yu9e4gg2u@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.w24t4yu9e4gg2u@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Atar,

2013-09-09 atar <atar.yosef@gmail.com>:

> Hi there!!
> 
> When I try to use the hciconfig command to initialized my Bluetooth
> antenna like the command:
> 
> hciconfig hci0 up OR hciconfig hci0 reset
> 
> it emits an error message saying:
> 
> Can't init device hci0: Connection timed out (110).

Could you please collect logs with hcidump or btmon and send them to us?

	Gustavo
