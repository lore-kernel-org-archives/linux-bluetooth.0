Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 12:50:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vladimir Davydov <vladimir.davydov@promwad.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sergey Kovalev <sergey.kovalev@promwad.com>
Subject: Re: Timeout in hciattach
Message-ID: <20100630094859.GA1738@jh-x301>
References: <201006171320.30987.vladimir.davydov@promwad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201006171320.30987.vladimir.davydov@promwad.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vladimir,

On Thu, Jun 17, 2010, Vladimir Davydov wrote:
> I have found that in the latest release of the bluez4 (4.66) timeout in 
> hciattach doesn't work.
> 
> Look at this code of hciattach.c:
> 
> static void bcsp_tshy_sig_alarm(int sig)
> {
> 	unsigned char bcsp_sync_pkt[10] = 
> {0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
> 	int len, retries = 0;
> 
> 	if (retries < bcsp_max_retries) {
> 		retries++;
> 		len = write(serial_fd, &bcsp_sync_pkt, 10);
> 		alarm(1);
> 		return;
> 	}
> 
> 	tcflush(serial_fd, TCIOFLUSH);
> 	fprintf(stderr, "BCSP initialization timed out\n");
> 	exit(1);
> }
> 
> The variable 'retries' will be always 0. Why is it not static? It was static 
> in oldest releases (3.33 for example).

It looks to me like this is a regression introduced by commit
72c6ed7e2d619048440ff528fca7fef59887fbaf from Marcel.

> I have attached simple patch to fix that.

Could you please send a patch in git format-patch format and also fix
the issue in in the other _alarm function (if you take a look at
Marcel's patch you'll see both places that need fixing).

Johan
