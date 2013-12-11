Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386758797-1809-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386758797-1809-1-git-send-email-marcin.kraglak@tieto.com>
Date: Wed, 11 Dec 2013 13:15:39 +0200
Message-ID: <CABBYNZ+174QCeZ1NBu8w5y5GVTq1WiTCu=zaBAR1z3uiYqYnyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] android/tester: Add android-tester
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Dec 11, 2013 at 12:46 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> This commit add android-tester.c to tree and Makefile.am.
> This will contain set of unit tests for testing android daemon.
> ---
>  .gitignore               |  1 +
>  android/Makefile.am      |  4 ++++
>  android/android-tester.c | 21 +++++++++++++++++++++
>  3 files changed, 26 insertions(+)
>  create mode 100644 android/android-tester.c
>
> diff --git a/.gitignore b/.gitignore
> index 2d3435a..c570728 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -107,3 +107,4 @@ unit/test-*.trs
>  android/system-emulator
>  android/bluetoothd
>  android/haltest
> +android/android-tester
> diff --git a/android/Makefile.am b/android/Makefile.am
> index df04762..0768985 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -83,6 +83,10 @@ android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
>
>  android_haltest_LDFLAGS = -pthread
>
> +noinst_PROGRAMS += android/android-tester
> +
> +android_android_tester_SOURCES = android/android-tester.c
> +
>  endif
>
>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
> diff --git a/android/android-tester.c b/android/android-tester.c
> new file mode 100644
> index 0000000..f5c42b0
> --- /dev/null
> +++ b/android/android-tester.c
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (C) 2013 Intel Corporation
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> + * See the License for the specific language governing permissions and
> + * limitations under the License.
> + *
> + */
> +
> +int main(int argc, char *argv[])
> +{
> +       return 0;
> +}
> --
> 1.8.3.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
