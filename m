Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2009 01:54:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 2/7] Adding set_powered method to hciops plugin.
Message-ID: <20090516225406.GA19041@jh-x301>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com> <1242131216-4081-2-git-send-email-alok.barsode@azingo.com> <20090515182256.GA18375@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090515182256.GA18375@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Fri, May 15, 2009, Johan Hedberg wrote:
> I'm going through your patches now and I found at least one issue:
> 
> > +	hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
> > +					1, SCAN_DISABLED);
> 
> This looks wrong. The last parameter should a pointer and not an integer.

There's another issue with this patch as well:
adapter.c: In function ‘set_mode’:
adapter.c:403: error: ‘dd’ may be used uninitialized in this function

I'd have fixed both issues for you (since they are rather trivial) but
then your third patch doesn't apply cleanly anymore. So please fix these
issues, check that no patch causes any compilation warning or error, and
resend them. Thanks.

Johan
