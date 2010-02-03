Return-Path: <cyrus@holtmann.org>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <90704.85857.qm@web52601.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>
	 <1265156906.31341.106.camel@localhost.localdomain>
	 <90704.85857.qm@web52601.mail.re2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 07:07:53 -0800
Message-ID: <1265209673.31341.116.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

> >> In hcidump I seem to see a problem in #3. After the Encrypt Change there seem to be 2 >con. req. psm 1 scid 0x0040
> 
> >what kernel version is this? I think we fixed that already.
> It is a ubutunu distribution. 2.6.31-17-generic.

can you test with a 2.6.33-rc6 vanilla kernel. I really thing this got
fixed and you might see a side effect or bad patch here.

Regards

Marcel


