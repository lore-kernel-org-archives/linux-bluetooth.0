Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 15:44:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lukasz.rymanowski@tieto.com
Subject: Re: [PATCHv2 hcidump 0/3] SAP PDU parsing
Message-ID: <20120330124413.GA4450@x220>
References: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, Mar 30, 2012, Andrzej Kaczmarek wrote:
> Hi,
> 
> This one is identical to v1 except for corrected copyright information
> in parser/sap.c
> 
> 
> Andrzej Kaczmarek (3):
>   Add basic SAP parsing
>   Add parameters parsing support for SAP PDU
>   core: Add support for passing RFCOMM channel for SAP
> 
>  Makefile.am     |    1 +
>  parser/parser.h |    2 +
>  parser/rfcomm.c |    7 ++
>  parser/sap.c    |  335 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/hcidump.c   |   11 +-
>  5 files changed, 355 insertions(+), 1 deletion(-)
>  create mode 100644 parser/sap.c

All patches in this set have been applied. Thanks.

Johan
