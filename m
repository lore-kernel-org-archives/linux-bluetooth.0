Return-Path: <cyrus@holtmann.org>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
From: Marcel Holtmann <marcel@holtmann.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <272603.59641.qm@web52603.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Feb 2010 16:28:26 -0800
Message-ID: <1265156906.31341.106.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

>   I was pulling my hair on opp a file to a Blackberry. Blackerry is set to "receive using bluetooth".
> 1. If the Blackberry was not paired before. It ran through ok: enter the pin, accept connection, accept the file.
> 2. If the Blackberry was paired and in it's device properties, I change the encryption off for my box. It ran through ok, accept connection, accept the file...
> 3. If the Blackberry was paired and I leave the device properties unchange (default is encryption on). It will fail, not seeing any prompt to accept the connection.
> 
> In hcidump I seem to see a problem in #3. After the Encrypt Change there seem to be 2 >con. req. psm 1 scid 0x0040

what kernel version is this? I think we fixed that already.

Regards

Marcel


