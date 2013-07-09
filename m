Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 14:41:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 5/6] sco-tester: Initial sco tester implementation
Message-ID: <20130709114152.GB22976@x220.p-661hnu-f1>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1373039207-20959-6-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1373039207-20959-6-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Jul 05, 2013, Frédéric Dalleau wrote:
> ---
>  Makefile.tools     |   12 +-
>  emulator/btdev.c   |   32 ++++
>  tools/sco-tester.c |  541 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 584 insertions(+), 1 deletion(-)
>  create mode 100644 tools/sco-tester.c

Could you please split the emulator update to a separate patch that
comes before the first sco-tester patch?

Johan
