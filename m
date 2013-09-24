Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com>
Date: Tue, 24 Sep 2013 08:57:24 -0400
Message-ID: <CAJdJm_MJEd-tAfhQypGXd_yuAVZp=vNQ1Sa_wde3Co+uwyAxCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] build: Add skeleton for BlueZ Android
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Sep 24, 2013 at 8:13 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> --- /dev/null
> +++ b/android/Android.mk
> @@ -0,0 +1,5 @@
> +LOCAL_PATH := $(call my-dir)
> +
> +# Retrieve BlueZ version from configure.ac file
> +BLUEZ_VERSION := $(shell grep AC_INIT $(LOCAL_PATH)/../configure.ac | tr -d ' ' | sed -e 's/.*(.*,\(.*\))/\1/')

It also works if you use the C preprocessor to get the version:

BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac |
cpp -P -D'AC_INIT(_,v)=v')


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
