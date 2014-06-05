Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/2] android/pts: Update GATT test result
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401985955-13502-2-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 5 Jun 2014 18:49:26 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Eva Kolanska <eva.kolanska@tieto.com>
Message-Id: <47F94139-57CC-4F76-81DE-5B7DFA829E60@holtmann.org>
References: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com> <1401985955-13502-2-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eva,

> ---
> android/pts-gatt.txt | 128 +++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 114 insertions(+), 14 deletions(-)
> 
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 08ade26..3f986ee 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -748,7 +748,16 @@ TC_GAW_SR_BI_06_C	PASS	haltest:
> 						<properties> 10 <permissions> 17
> 				gatts start_service
> 				gatts send_response: <status> 12
> -TC_GAW_SR_BV_05_C	INC
> +TC_GAW_SR_BV_05_C       PASS	haltest:

can we please stick with using tabs here.

Regards

Marcel

