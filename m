Return-Path: <jirislaby@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: vhci, fix open_timeout vs. hdev race
To: Takashi Iwai <tiwai@suse.de>
References: <1458380852-7533-1-git-send-email-jslaby@suse.cz>
 <1458381918-7886-1-git-send-email-jslaby@suse.cz>
 <s5hio0e4np7.wl-tiwai@suse.de>
Cc: johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, "stable 3 . 13+" <stable@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <56F16A2C.6080303@suse.cz>
Date: Tue, 22 Mar 2016 16:52:12 +0100
MIME-Version: 1.0
In-Reply-To: <s5hio0e4np7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/22/2016, 03:00 PM, Takashi Iwai wrote:
> int main()
> {
> 	int i;
> 	long fd;
>         pthread_t th[32];
> 
> 	fd = open("/dev/vhci", O_RDWR);
> 	if (fd < 0)
> 		err(1, "open");
>         for (i = 0; i < 32; i++)
> 		pthread_create(&th[i], 0, test, (void*)fd);
>         for (i = 0; i < 32; i++)
> 		pthread_join(th[i], NULL);
> 	return 0;
> }
> ================================================================
> 
> For fixing these, we need a proper mutex protection.  A patch like
> below seems helping, at least for the test case above.

I didn't fix this and kept it simple as I believe concurrent accesses
from a single opener are not allowed by design. But if we want to
support this, we of course need locking like this.

Anyway, I would appreciate any input from the BT fellows. There are more
races like this, apparently.

thanks,
-- 
js
suse labs
