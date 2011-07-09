Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 19:22:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Return empty body instead -ENOENT when
 phonebook is empty
Message-ID: <20110709162209.GE11005@dell.ger.corp.intel.com>
References: <1309520562-19408-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309520562-19408-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Jul 01, 2011, Rafal Michalski wrote:
> Previously, when doing pull of empty phonebook, NOT FOUND error was
> returned. Now returning empty body - this change is needed to pass PTS
> testcase TC_PSE_PDF_BV_05_I (this testcase is optional).
> 
> PBAP spec says, that error NOT_FOUND should be returned when phonebook
> object could not be found - very strict clients may think that
> phonebook does not exist (and in scenario described above phonebook
> exists but its content is empty).
> ---
>  plugins/pbap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Both patches have been applied. Thanks.

Johan
