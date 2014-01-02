Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jan 2014 00:55:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com,
	luiz.dentz@gmail.com
Subject: Re: [PATCH] shared: Fix build issue for Android
Message-ID: <20140102225514.GA30700@x220.p-661hnu-f1>
References: <1388701892-13966-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388701892-13966-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jan 02, 2014, Lukasz Rymanowski wrote:
> target thumb C: bluetoothd-snoop <=
> external/bluetooth/bluez/android/../src/shared/btsnoop.c
> external/bluetooth/bluez/android/../src/shared/btsnoop.c: In function
> 'btsnoop_create':
> external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:6: error:
> 'S_IRUSR' undeclared (first use in this function)
> external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:6: note:
> each undeclared identifier is reported only once for each function it
> appears in
> external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:16: error:
> 'S_IWUSR' undeclared (first use in this function)
> external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:26: error:
> 'S_IRGRP' undeclared (first use in this function)
> external/bluetooth/bluez/android/../src/shared/btsnoop.c:126:36: error:
> 'S_IROTH' undeclared (first use in this function)
> 
> ---
>  src/shared/btsnoop.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
