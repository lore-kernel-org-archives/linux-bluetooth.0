Return-Path: <cyrus@holtmann.org>
Message-ID: <1355925987.1827.5.camel@aeonflux>
Subject: Re: [PATCH BlueZ] build: Check for UDEV before setting
 rulesdir/rules_DATA
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 19 Dec 2012 15:06:27 +0100
In-Reply-To: <1355921804-12533-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1355921804-12533-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> Without this check, UDEV_DIR will be empty and an empty "/rules.d"
> directory is created on DESTDIR.
> ---
>  Makefile.am |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile.am b/Makefile.am
> index a482b54..c10c1fa 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -174,6 +174,7 @@ test_scripts =
>  include Makefile.tools
>  include Makefile.obexd
>  
> +if UDEV
>  rulesdir = @UDEV_DIR@/rules.d
>  
>  udev_files =
> @@ -187,6 +188,7 @@ EXTRA_DIST += tools/hid2hci.rules
>  rules_DATA = $(foreach file,$(udev_files), tools/97-$(notdir $(file)))
>  
>  CLEANFILES += $(rules_DATA)
> +endif

great catch, but I fixed this differently by hiding this behind the
HID2HCI condition.

On a side note, you fix has the issue that EXTRA_DIST is now skipped and
that means it would have broken make distcheck by not including the
actual rule file.

Regards

Marcel


