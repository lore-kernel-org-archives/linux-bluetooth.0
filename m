Return-Path: <cyrus@holtmann.org>
Message-ID: <1412672146.919.5.camel@gentoo.org>
Subject: Re: Regarding why some tools are not installed
From: Pacho Ramos <pacho@gentoo.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Tue, 07 Oct 2014 10:55:46 +0200
In-Reply-To: <1410689236.29532.12.camel@gentoo.org>
References: <1410689236.29532.12.camel@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El dom, 14-09-2014 a las 12:07 +0200, Pacho Ramos escribió:
> Hello
> 
> Recently a user told me that he needed to use hex2hcd to get his
> Broadcom firmware loaded by his bluetooth adaptor. We wonder about why
> it's not installed by default when we build with "experimental"
> configure option:
> if EXPERIMENTAL
> noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
>                         tools/scotest tools/amptest tools/hwdb \
>                         tools/hcieventmask tools/hcisecfilter \
>                         tools/btmgmt tools/btinfo tools/btattach \
>                         tools/btsnoop tools/btproxy tools/btiotest \
>                         tools/cltest tools/seq2bseq tools/hex2hcd \
>                         tools/ibeacon tools/btgatt-client
> (in Makefile.tools)
> 
> Thanks a lot for the info
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

The same occurs with gatttool :/, do you know why they are explicitly
not installed? 

