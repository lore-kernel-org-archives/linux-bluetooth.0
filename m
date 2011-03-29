Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 17:50:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unused variable in mgmtops plugin
Message-ID: <20110329145049.GA12595@jh-x301>
References: <1301409722-16198-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301409722-16198-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 29, 2011, Claudio Takahasi wrote:
> ---
>  plugins/mgmtops.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
> index 65b32e6..3f96017 100644
> --- a/plugins/mgmtops.c
> +++ b/plugins/mgmtops.c
> @@ -1410,7 +1410,6 @@ static void mgmt_cleanup(void)
>  {
>  	g_free(controllers);
>  	controllers = NULL;
> -	max_index = -1;
>  
>  	if (mgmt_sock >= 0) {
>  		close(mgmt_sock);

I don't understand the purpose of this patch. You're neither removing a
variable (just removing an assignment) nor is the variable you're
touching unused.

Johan
