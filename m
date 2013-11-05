Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 10:31:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/11] android/hid: Implement hid set report in daemon
Message-ID: <20131105083105.GC20907@x220.p-661hnu-f1>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383603615-9953-8-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383603615-9953-8-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
> This patch requests hid device to set report.
> ---
>  android/hal-hidhost.c |  1 +
>  android/hal-msg.h     |  1 +
>  android/hid.c         | 40 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 40 insertions(+), 2 deletions(-)

Again, split this into separate patches.

> diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
> index 027e3b8..040d517 100644
> --- a/android/hal-hidhost.c
> +++ b/android/hal-hidhost.c
> @@ -284,6 +284,7 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
>  		return BT_STATUS_PARM_INVALID;
>  
>  	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
> +	cmd.report = report;
>  
>  	switch (reportType) {
>  	case BTHH_INPUT_REPORT:
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index eaa5c9c..e1fd027 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -292,6 +292,7 @@ struct hal_cmd_hid_get_report {
>  struct hal_cmd_hid_set_report {
>  	uint8_t bdaddr[6];
>  	uint8_t type;
> +	char *report;
>  } __attribute__((packed));

Seriously? Trying to send pointers over IPC :)

Also verify that whatever you add matches what we have in
hal-ipc-api.txt (and if the API documentation is wrong or missing
something fix it).

Johan
