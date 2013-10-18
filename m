Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 16:19:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add missing signal handler functionality
Message-ID: <20131018131950.GA10623@x220.p-661hnu-f1>
References: <1382101802-23965-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382101802-23965-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Fri, Oct 18, 2013, Ravi kumar Veeramally wrote:
> Added singal handling based on singalfd and removed sigaction
> based code.
> ---
>  android/main.c |   80 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 15 deletions(-)

Applied (after a minor fix to exit the daemon if the setup function
fails). Thanks.

Johan
