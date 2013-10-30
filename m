Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 11:16:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] android: Add README file with instructions
Message-ID: <20131030091604.GA17598@x220.p-661hnu-f1>
References: <1383123916-20721-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383123916-20721-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 30, 2013, Szymon Janc wrote:
> This file cotains help on how BlueZ for Android should be build, run
> and test. Some hints and examples on how BlueZ can be intergrated into
> Android are present as well.
> ---
> v4:
>  - workarounded issue with leftover conflicting markers
>   
>   for the record: it appears that double appearance of lines with
>   =======
>   (7 equality marks) confuses git that there is unresolved conflict.
> 
>  android/Makefile.am |  2 +-
>  android/README      | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 android/README

Applied. Thanks.

Johan
