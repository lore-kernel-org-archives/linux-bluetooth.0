Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] android/pts: Update PTS GAP test results
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403010877-2391-1-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 17 Jun 2014 15:25:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7E4165A9-212E-4981-8197-D6B7EAF444B7@holtmann.org>
References: <1403010877-2391-1-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> android/pts-gap.txt | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index cd70326..bb7f172 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -217,8 +217,11 @@ TC_SEC_AUT_BV_18_C	PASS	haltest: gattc register_client
> 				bluetooth create_bond
> 				gattc read_characteristic
> TC_SEC_AUT_BV_19_C	PASS
> -TC_SEC_AUT_BV_20_C	INC	Link security level elevation - not implemented
> -TC_SEC_AUT_BV_21_C	INC	Link security level elevation - not implemented
> +TC_SEC_AUT_BV_20_C	INC	PTS issue [ID:12284]

lets be a bit consistent on how we comment the PTS issue. I have scripts that run through the files and summarize them. So it needs to be consistent.

Regards

Marcel

