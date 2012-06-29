Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jun 2012 14:14:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] network: Reply to extensions at connection setup
Message-ID: <20120629111454.GB19540@x220>
References: <1338470470-6874-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1338470470-6874-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, May 31, 2012, Frédéric Dalleau wrote:
> TP/BNEP/CTRL/BV-19-C is about extension in the BNEP_SETUP_CONN_REQ
> control message. BNEP_SETUP_CONN_REQ is handled by bluetoothd before
> giving control to kernel.  Current bluez do not reply at all if an
> extension is added to BNEP_SETUP_CONN_REQ. This patch fixes it by
> sending COMMAND_NOT_UNDERSTOOD reply.
> 
> The test sends the following message :
> > ACL data: handle 11 flags 0x02 dlen 37
>   L2CAP(d): cid 0x0040 len 33 [psm 15]
>     BNEP: Control(0x01|1)
>       Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
>       Ext Control(0x00|1) len 0x07
>         Filter NetType Set(0x03) len 0x0004
>           0x8600 - 0x86dd
>       Ext Control(0x00|0) len 0x0f
>         Filter MultAddr Set(0x05) len 0x000c
>           03:00:00:20:00:00 - 03:00:00:20:00:00
> 
> A reply must be provided to each of the extensions, the patch triggers
> the following answer:
> < ACL data: handle 12 flags 0x00 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 15]
>       BNEP: Control(0x01|0)
>         Setup Rsp(0x02) res 0x0000
> < ACL data: handle 12 flags 0x00 dlen 7
>     L2CAP(d): cid 0x0040 len 3 [psm 15]
>       BNEP: Control(0x01|0)
>         Not Understood(0x00) type 0x03
> < ACL data: handle 12 flags 0x00 dlen 7
>     L2CAP(d): cid 0x0040 len 3 [psm 15]
>       BNEP: Control(0x01|0)
>         Not Understood(0x00) type 0x05
> 
> The following command can be used for testing:
> printf "\x81\x01\x02\x11\x16\x11\x15\x80\x07\x03\x00\x04\x86\x00"\
> "\x86\xdd\x00\x0f\x05\x00\x0c\x03\x00\x00\x20\x00\x00\x03\x00\x00"\
> "\x20\x00\x00" > BNEP_CTRL_19.bin
> ./l2test -n -P 15 bb:dd:aa:dd:dd:rr -B BNEP_CTRL_19.bin -y
> ---
>  network/server.c |   36 ++++++++++++++++++++++++++++++++++--
>  1 files changed, 34 insertions(+), 2 deletions(-)

What was the conclusion for this patch? Should it be applied to user
space upstream or was there some decision to only handle this on the
kernel side?

Johan
