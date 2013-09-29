Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Sep 2013 18:00:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 16/16] android: Add HAL message helpers
Message-ID: <20130929150031.GB28937@x220.p-661hnu-f1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380291161-10232-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013, Andrei Emeltchenko wrote:
> +int open_hal_chan(void)
> +{
> +	int tries = 10;
> +	int sock;
> +
> +	while (tries-- > 0) {
> +		sock = socket_local_client(BLUEZ_SOCKET,
> +					ANDROID_SOCKET_NAMESPACE_RESERVED,
> +					SOCK_STREAM);

Again, should be s/STREAM/SEQPACKET/ here.

Johan
