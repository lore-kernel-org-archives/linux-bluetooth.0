Return-Path: <cyrus@holtmann.org>
Message-ID: <1343860473.1803.96.camel@aeonflux>
Subject: Re: [PATCH v16 01/14] doc: Add telephony interface documents
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 Aug 2012 15:34:33 -0700
In-Reply-To: <1343812131-19395-2-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
	 <1343812131-19395-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  Makefile.am                    |    2 +-
>  doc/assigned-numbers.txt       |    1 +
>  doc/audio-api.txt              |   87 +++++++++++++++++++++++++++++++++
>  doc/audio-telephony-design.txt |  106 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 195 insertions(+), 1 deletion(-)
>  create mode 100644 doc/audio-telephony-design.txt
> 
> diff --git a/Makefile.am b/Makefile.am
> index 45a811c..1aa302c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -381,7 +381,7 @@ EXTRA_DIST += doc/manager-api.txt \
>  		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
>  		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
>  		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt \
> -		doc/supported-features.txt
> +		doc/supported-features.txt doc/audio-telephony-design.txt
>  
>  AM_YFLAGS = -d
>  
> diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
> index cda934c..120d7ea 100644
> --- a/doc/assigned-numbers.txt
> +++ b/doc/assigned-numbers.txt
> @@ -8,6 +8,7 @@ avoid conflicts.
>  Profile		Channel
>  -----------------------
>  DUN		1
> +HSP HS		6
>  HFP HF		7
>  OPP		9
>  FTP		10

this needs to be a separate patch.

Regards

Marcel


