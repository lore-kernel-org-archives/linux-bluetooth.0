Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix possible crash while verifying avdtp version
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c101002170139x52314d9g7b665c7fb769f40c@mail.gmail.com>
References: <2d5a2c101002170139x52314d9g7b665c7fb769f40c@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Feb 2010 02:01:41 -0800
Message-ID: <1266400901.8849.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Codenomicon a2dp tests makes bluetoothd to crash due to a malformed
> sdp record (BlueZ 4.60):
> 
> Signal 11 (SIGSEGV)
> 0		avdtp_get_internal () at audio/avdtp.c:2073
> 1	0x00022f18	avdtp_confirm_cb (chan=0x6c0e0) at audio/avdtp.c:2266
> 2	0x0003a7dc	server_cb (user_data=0x6d380) at src/btio.c:193

patch has been applied. Thanks.

Regards

Marcel


