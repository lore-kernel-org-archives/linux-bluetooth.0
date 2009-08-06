Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Modify PBAP SDP record.
From: Marcel Holtmann <marcel@holtmann.org>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org, Zhu Lan <mtcb47@motorola.com>
In-Reply-To: <e8892a6a0908061400h4b07c3c5pcaa7992026dc90c@mail.gmail.com>
References: <1249588984-9043-1-git-send-email-jaikumar@google.com>
	 <1249589381.21101.22.camel@localhost.localdomain>
	 <e8892a6a0908061400h4b07c3c5pcaa7992026dc90c@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Aug 2009 14:12:51 -0700
Message-Id: <1249593171.21101.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

>         > Fix to pass PTS case TC_SDAS_BV_03_I(since PTS3.2 update2).
>         > The code tried to append the UINT type value to the
>         supported
>         > respositories.  However, the wrong function sdp_seq_alloc()
>         > was used. This function adds 2 redundant bytes (SDP_SEQ8 as
>         > 0x35, seq) ahead of 0x08, so that latest PTS IOPT will fail.
>         > According to spec, PBAP attributes should report 0x08 0x01
>         > or 0x08 0x03 right after 0x0314. The correct function to use
>         > is sdp_data_alloc(), with clean 0x08 0x01 appended as
>         > SDP_ATTR_SUPPORTED_REPOSITORIES.
>         > ---
>         >  tools/sdptool.c |    9 ++-------
>         >  1 files changed, 2 insertions(+), 7 deletions(-)
>         
>         
>         can I get a version of this patch that applies cleanly when
>         using git am
>         please.
> 
> Attached.

make[2]: Entering directory `/data/devel/bluez/tools'
  CC     sdptool.o
gcc1: warnings being treated as errors
sdptool.c: In function ‘add_pbap’:
sdptool.c:1834: error: unused variable ‘i’
sdptool.c:1833: error: unused variable ‘values’
sdptool.c:1833: error: unused variable ‘dtds’

I thought that I make myself clear that every patch has to compile
without any compiler warnings. What is this here? We hack around as we
like and don't bother? Use freaking --enable-maintainer-mode or set the
same compiler options BlueZ uses upstream.

Patch pushed and also fixed now.

Regards

Marcel


