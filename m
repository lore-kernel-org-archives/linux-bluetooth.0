Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jul 2011 12:34:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/5 v2] Change EDS backend to support multiple
 ebooks
Message-ID: <20110711093408.GA5020@dell.ger.corp.intel.com>
References: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309899202-23849-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Jul 05, 2011, Bartosz Szatkowski wrote:
> Until now only default ebook was used, this patch change this behaviour
> so each function is run on all available (active) ebooks and merging
> results from each of them.
> ---
>  plugins/phonebook-ebook.c |  293 ++++++++++++++++++++++++++++++---------------
>  1 files changed, 196 insertions(+), 97 deletions(-)

All five patches have been applied. Thanks.

Johan
