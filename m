Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jan 2014 15:50:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/bluetooth: Fix discovering new devices
Message-ID: <20140116135032.GA1267@x220.p-661hnu-f1>
References: <1389879325-21217-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389879325-21217-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 16, 2014, Szymon Janc wrote:
> @@ -983,12 +994,15 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  	eir_parse(&eir, data, data_len);
>  
>  	dev = find_device(bdaddr);
> -	if (!dev) {
> +	if (!dev || !dev->found) {

I think this would still deserve a code comment here explaining why
dev->found is important. Other than that the patch is fine, so feel free
to push it yourself once you've added the comment.

Johan
