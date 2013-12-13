Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386862737-30606-1-git-send-email-szymon.janc@tieto.com>
References: <1386862737-30606-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 13 Dec 2013 11:24:41 +0200
Message-ID: <CABBYNZJjUfAsJJODh_uBBjSaQtC6DLVMAoQKCc6+ozWQvPChFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/pts: Add PTS test results for OPP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Dec 12, 2013 at 5:38 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This will allow for better tracking of current state of implementation.
> ---
>  android/Makefile.am |  3 +-
>  android/pts-opp.txt | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 1 deletion(-)
>  create mode 100644 android/pts-opp.txt
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 1dde8c1..bcd9f2b 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -110,4 +110,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
>                 android/pixit-did.txt android/pts-did.txt \
>                 android/pixit-gap.txt android/pixit-hid.txt \
>                 android/pixit-opp.txt android/pixit-pan.txt \
> -               android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt
> +               android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt \
> +               android/pts-opp.txt
> diff --git a/android/pts-opp.txt b/android/pts-opp.txt
> new file mode 100644
> index 0000000..b9329b9
> --- /dev/null
> +++ b/android/pts-opp.txt
> @@ -0,0 +1,94 @@
> +PTS test results for OPP
> +
> +PTS version: 4.9
> +Tested: 14.11.2013
> +
> +Results:
> +PASS   test passed
> +FAIL   test failed
> +INC    test is inconclusive
> +N/A    test is disabled due to PICS setup
> +
> +-------------------------------------------------------------------------------
> +Test Name              Result  Notes
> +-------------------------------------------------------------------------------
> +TC_CLIENT_OPH_BV_01_I  PASS
> +TC_CLIENT_OPH_BV_02_I  N/A
> +TC_CLIENT_OPH_BV_03_I  PASS
> +TC_CLIENT_OPH_BV_04_I  N/A
> +TC_CLIENT_OPH_BV_05_I  PASS
> +TC_CLIENT_OPH_BV_07_I  N/A
> +TC_CLIENT_OPH_BV_08_I  N/A
> +TC_CLIENT_OPH_BV_09_I  N/A
> +TC_CLIENT_OPH_BV_10_I  N/A
> +TC_CLIENT_OPH_BV_11_I  N/A
> +TC_CLIENT_OPH_BV_12_I  N/A
> +TC_CLIENT_OPH_BV_13_I  N/A
> +TC_CLIENT_OPH_BV_14_I  N/A
> +TC_CLIENT_OPH_BV_15_I  N/A
> +TC_CLIENT_OPH_BV_16_I  N/A
> +TC_CLIENT_OPH_BV_17_I  N/A
> +TC_CLIENT_OPH_BV_18_I  N/A
> +TC_CLIENT_OPH_BV_19_I  PASS
> +TC_CLIENT_OPH_BV_20_I  PASS
> +TC_CLIENT_OPH_BV_22_I  PASS
> +TC_CLIENT_OPH_BV_23_I  PASS
> +TC_CLIENT_OPH_BV_24_I  N/A
> +TC_CLIENT_OPH_BV_25_I  N/A
> +TC_CLIENT_OPH_BV_26_I  N/A
> +TC_CLIENT_OPH_BV_34_I  PASS
> +TC_CLIENT_OPH_BI_01_C  PASS
> +TC_CLIENT_BCP_BV_01_I  N/A
> +TC_CLIENT_BCP_BV_02_I  N/A
> +TC_CLIENT_BCP_BV_03_I  N/A
> +TC_CLIENT_BCP_BV_04_I  N/A
> +TC_CLIENT_BCP_BV_05_I  N/A
> +TC_CLIENT_BCE_BV_01_I  N/A
> +TC_CLIENT_BCE_BV_03_I  N/A
> +TC_CLIENT_BCE_BV_04_I  N/A
> +TC_CLIENT_BCE_BV_05_I  N/A
> +TC_CLIENT_BCE_BV_06_I  N/A
> +TC_CLIENT_BCE_BV_07_I  N/A
> +TC_SERVER_OPH_BV_01_I  PASS
> +TC_SERVER_OPH_BV_02_I  PASS
> +TC_SERVER_OPH_BV_03_I  PASS
> +TC_SERVER_OPH_BV_04_I  PASS
> +TC_SERVER_OPH_BV_05_I  PASS
> +TC_SERVER_OPH_BV_07_I  N/A
> +TC_SERVER_OPH_BV_08_I  N/A
> +TC_SERVER_OPH_BV_09_I  N/A
> +TC_SERVER_OPH_BV_10_I  PASS
> +TC_SERVER_OPH_BV_11_I  N/A
> +TC_SERVER_OPH_BV_12_I  N/A
> +TC_SERVER_OPH_BV_13_I  N/A
> +TC_SERVER_OPH_BV_14_I  PASS
> +TC_SERVER_OPH_BV_15_I  N/A
> +TC_SERVER_OPH_BV_16_I  N/A
> +TC_SERVER_OPH_BV_17_I  N/A
> +TC_SERVER_OPH_BV_18_I  PASS
> +TC_SERVER_OPH_BV_19_I  PASS
> +TC_SERVER_OPH_BV_21_I  N/A
> +TC_SERVER_OPH_BV_22_I  PASS
> +TC_SERVER_OPH_BV_23_I  PASS
> +TC_SERVER_OPH_BV_24_I  N/A
> +TC_SERVER_OPH_BV_25_I  N/A
> +TC_SERVER_OPH_BV_26_I  N/A
> +TC_SERVER_OPH_BV_34_I  PASS
> +TC_SERVER_BCP_BV_01_I  N/A
> +TC_SERVER_BCP_BV_02_I  PASS
> +TC_SERVER_BCP_BV_03_I  N/A
> +TC_SERVER_BCP_BV_04_I  N/A
> +TC_SERVER_BCP_BV_05_I  N/A
> +TC_SERVER_BCE_BV_01_I  N/A
> +TC_SERVER_BCE_BV_03_I  N/A
> +TC_SERVER_BCE_BV_04_I  N/A
> +TC_SERVER_BCE_BV_05_I  N/A
> +TC_SERVER_BCE_BV_06_I  N/A
> +TC_SERVER_BCE_BV_07_I  N/A
> +TC_CLIENT_OPH_BV_27_I  N/A
> +TC_SERVER_OPH_BV_27_I  N/A
> +TC_SERVER_OPH_BV_30_I  N/A
> +TC_SERVER_OPH_BV_31_I  N/A
> +TC_SERVER_OPH_BV_32_I  N/A
> +TC_SERVER_OPH_BV_33_I  N/A
> +-------------------------------------------------------------------------------
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
