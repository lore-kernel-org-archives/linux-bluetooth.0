Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jun 2013 13:00:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 21/35] tools/mgmt-tester: Add support for second
 controller
Message-ID: <20130619100033.GC6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
 <1371041841-21793-22-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371041841-21793-22-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 12, 2013, Bruna Moreira wrote:
> Add second controller to tester and let a testcase start discovery and
> receive Device Found events.
> ---
>  tools/mgmt-tester.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index cbff775..a27b2e2 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -56,6 +56,8 @@ struct test_data {
>  	uint16_t mgmt_index;
>  	struct hciemu *hciemu;
>  	enum hciemu_type hciemu_type;
> +	struct hciemu *hciemu_second;
> +	uint16_t mgmt_index_second;
>  	int unmet_conditions;
>  };

It seems to me that this is exactly why bthost exists, i.e. the hciemu
instance already contains a peer controller combined with an emulated
host stack.

Johan
