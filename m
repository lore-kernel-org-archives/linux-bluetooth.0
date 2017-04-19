Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ] monitor: Add frame number support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170419184012.5650-1-luiz.dentz@gmail.com>
Date: Wed, 19 Apr 2017 21:35:07 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BF7CE46B-E25F-42C2-84C2-152F3A453595@holtmann.org>
References: <20170419184012.5650-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds -f/--frames options which can be used to show the frame
> number:
> 
>  #1 < HCI Command: Write Voice Setting (0x03|0x0026) plen 2
>        Setting: 0x0060
>          Input Coding: Linear
>          Input Data Format: 2's complement
>          Input Sample Size: 16-bit
>          # of bits padding at MSB: 0
>          Air Coding Format: CVSD
>  #2 > HCI Event: Command Complete (0x0e) plen 4
>      Write Voice Setting (0x03|0x0026) ncmd 1
>        Status: Success (0x00)

I have been avoiding adding anything in the front. So if you want extra indicators, they go at the end of the line.

Regards

Marcel

