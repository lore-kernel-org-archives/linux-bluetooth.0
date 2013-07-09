Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 14:42:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v2 6/6] sco-tester: Test BT_VOICE option with 1.1 adapter
Message-ID: <20130709114245.GC22976@x220.p-661hnu-f1>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1373039207-20959-7-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1373039207-20959-7-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Jul 05, 2013, Frédéric Dalleau wrote:
> ---
>  emulator/btdev.c    |   25 +++++++++++++++++++
>  emulator/btdev.h    |    1 +
>  src/shared/hciemu.c |    8 +++++++
>  src/shared/hciemu.h |    1 +
>  tools/sco-tester.c  |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 100 insertions(+), 1 deletion(-)

Here also, please split the emulator and hciemu changes to separate
patches before the sco-tester patch.

Johan
