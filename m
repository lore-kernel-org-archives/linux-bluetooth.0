Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 10:59:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 0/7] Initial code for hal hid host
Message-ID: <20131023075908.GA5084@x220.p-661hnu-f1>
References: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382514120-13152-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wed, Oct 23, 2013, Ravi kumar Veeramally wrote:
> Patch set is all about initial code for hal hidhost interfaces which
> are .virtual_unplug, .set_info, .get_protocol, .set_protocol,
> .get_report, .set_report and .send_data. Also includes issue fixes
> for .connect and .disconnect interfaces.
> ---
> _v2 is about fixing issues as per Johan comments.
> 
> Ravi kumar Veeramally (7):
>   android: Return right from hal_ipc_cmd call in hal hid connect
>   android: Return right from hal_ipc_cmd call in hal hid disconnect
>   android: Add initial code for hidhost virtual unplug
>   android: Add initial code for hidhost get and set protocol
>   android: Add initial code for hidhost get and set report
>   android: Add initial code for hidhost send data
>   android: Add initial code for hidhost set hid information
> 
>  android/hal-hidhost.c |  126 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 105 insertions(+), 21 deletions(-)

All patches have been applied (after some minor coding style fixes).
Thanks.

Johan
