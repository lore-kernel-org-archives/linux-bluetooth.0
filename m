Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 22:01:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v1] gdbus: Fix compilation error if macro "error"
 is defined
Message-ID: <20120816190124.GB25826@x220.P-661HNU-F1>
References: <1345121479-9797-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345121479-9797-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Aug 16, 2012, Jaganath Kanakkassery wrote:
> The variable "signature" used in error is not defined and "args" is now
> a struct instead of a string.
> ---
> v1 -> Made a note of the removal of variable "args" in the commit message
> 
>  gdbus/object.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Applied to bluez.git and obexd.git. Thanks.

Johan
