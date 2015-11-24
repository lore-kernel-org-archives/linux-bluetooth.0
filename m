Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Bug in batostr()?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <354132869.329670308.1448374597432.JavaMail.root@zimbra62-e11.priv.proxad.net>
Date: Tue, 24 Nov 2015 13:18:46 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7CA45173-4B21-486D-AFFA-D81B2E4F5F16@holtmann.org>
References: <354132869.329670308.1448374597432.JavaMail.root@zimbra62-e11.priv.proxad.net>
To: acalando@free.fr
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antoine,

> In lib/bluetooth.c, it looks like batostr() is bugged (wrong bytes order), 
> after comparison with ba2str():
> 
> char *batostr(const bdaddr_t *ba)
> 	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
> 		ba->b[0], ba->b[1], ba->b[2],
> 		ba->b[3], ba->b[4], ba->b[5]);
> 
> int ba2str(const bdaddr_t *ba, char *str)
> 	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
> 		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
> 
> This function is not called anywhere else in the repository, that is probably 
> why the problem never showed up.

they are on purpose this way. That is why we also have baswap.

Regards

Marcel

