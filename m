Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1385631770-3858-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631770-3858-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1385631770-3858-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Thu, 5 Dec 2013 17:00:23 +0200
Message-ID: <CABBYNZK++FwBxfH2Hya8GVwXhMSMmbC+mwvzA+_fLKa6+V6jzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] android: Add android-tester
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thu, Nov 28, 2013 at 11:42 AM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> From: Marcin Kraglak <marcin.kraglak@tieto.com>
>
> This commit add android-tester.c to tree and Makefile.am.
> This will contain set of unit tests for testing android daemon.
> ---
>  android/Makefile.am      |  4 ++++
>  android/android-tester.c | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 android/android-tester.c
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 94d231f..9390422 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -82,6 +82,10 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
>
>  android_haltest_LDFLAGS = -pthread
>
> +noinst_PROGRAMS += android/android-tester
> +
> +android_android_tester_SOURCES = android/android-tester.c
> +
>  endif

You should probably add it to .gitignore as well. Also is this suppose
to be run in the host only or do we want to run in Android as well?

-- 
Luiz Augusto von Dentz
