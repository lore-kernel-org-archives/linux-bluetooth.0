Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
References: <1407334287-6721-1-git-send-email-sebastian.chlad@tieto.com>
Date: Mon, 11 Aug 2014 13:17:44 +0200
Message-ID: <CAN_7+YYrhaLy+M5-7L5YUovgujs0quzXZojRZxNgiO5tRzz0aw@mail.gmail.com>
Subject: Re: [PATCH] android/pts: Update PTS files for L2CAP
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wed, Aug 6, 2014 at 4:11 PM, Sebastian Chlad
<sebastian.chlad@tieto.com> wrote:
> PICS and PIXITs checked against PTS 5.2. Regression round on PTS
> 5.2 against Android 4.4.4.
> ---
>  android/pics-l2cap.txt  | 11 ++++++----
>  android/pixit-l2cap.txt |  2 +-
>  android/pts-l2cap.txt   | 57 +++++++++++++++++++++++++++----------------------
>  3 files changed, 40 insertions(+), 30 deletions(-)
>
> diff --git a/android/pics-l2cap.txt b/android/pics-l2cap.txt
> index 53e6b9f..8e726e4 100644
> --- a/android/pics-l2cap.txt
> +++ b/android/pics-l2cap.txt
> @@ -1,6 +1,6 @@
>  L2CAP PICS for the PTS tool.
>
> -PTS version: 5.1
> +PTS version: 5.2
>
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -70,7 +70,8 @@ TSPC_L2CAP_2_31       False           AMP Manager Support (C.12)
>  TSPC_L2CAP_2_32        False           ERTM over AMP (C.12)
>  TSPC_L2CAP_2_33        False           Streaming Mode Source over AMP Support (C.15)
>  TSPC_L2CAP_2_34        False           Streaming Mode Sink over AMP Support (C.15)
> -TSPC_L2CAP_2_35        True (*)        Unicast Connectionless Data, Reception (C.1, C.16)
> +TSPC_L2CAP_2_35        True (*)        Unicast Connectionless Data, Reception
> +                               (C.1, C.16)
>  TSPC_L2CAP_2_36        True (*)        Ability to transmit an unencrypted packet over
>                                         a Unicast connectionless L2CAP
>                                         channel (C.16)
> @@ -105,7 +106,8 @@ C.10: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
>  C.11: Optional IF TSPC_L2CAP_2_12 is claimed, ELSE Excluded.
>  C.12: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
>  C.13: Mandatory IF SUM_ICS 31/9 (3.0 + HS) is claimed, ELSE Optional.
> -C.14: Optional IF SUM_ICS 31/8 OR 31/9 OR 31/10 OR 31/11 is claimed, ELSE Excluded.
> +C.14: Optional IF SUM_ICS 31/8 OR 31/9 OR 31/10 OR 31/11 is claimed,
> +       ELSE Excluded.
>  C.15: Optional IF TSPC_L2CAP_2_29 is claimed, ELSE Excluded.
>  C.16: Optional IF (SUM_ICS 31/8 OR SUM_ICS 31/9 OR 31/10 OR 31/11) is claimed,
>         ELSE Excluded.
> @@ -154,6 +156,7 @@ C.4: Mandatory IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
>  C.5: Optional IF BR/EDR OR BR/EDR/LE is claimed, ELSE Excluded.
>  C.6: Mandatory IF LE OR BR/EDR/LE is claimed, ELSE Excluded.
>  C.7: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
> -C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
> +C.8: Mandatory if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported,
> +       ELSE Excluded.
>  C.9: Optional if TSPC_L2CAP_2_44 OR TSPC_L2CAP_2_38 is supported, ELSE Excluded.
>  -------------------------------------------------------------------------------
> diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
> index 914a995..401e584 100644
> --- a/android/pixit-l2cap.txt
> +++ b/android/pixit-l2cap.txt
> @@ -1,6 +1,6 @@
>  L2CAP PIXIT for the PTS tool.
>
> -PTS version: 5.1
> +PTS version: 5.2
>
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
> index 29e6d7c..11ea04f 100644
> --- a/android/pts-l2cap.txt
> +++ b/android/pts-l2cap.txt
> @@ -1,8 +1,8 @@
>  PTS test results for L2CAP
>
> -PTS version: 5.1
> -Tested: 27-June-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 14-July-2014
> +Android version: 4.4.4
>  Kernel version: 3.17
>
>  Results:
> @@ -58,8 +58,10 @@ TC_CMC_BV_08_C               PASS    l2test -r -X streaming -P 4113
>  TC_CMC_BV_09_C         PASS    l2test -r -X basic -P 4113
>  TC_CMC_BV_10_C         PASS    l2test -n -P 4113 <bdaddr>
>  TC_CMC_BV_11_C         PASS    l2test -n -P 4113 <bdaddr>
> -TC_CMC_BV_12_C         PASS    l2test -s -X ertm -P 4113 -U <bdaddr>
> -TC_CMC_BV_13_C         PASS    l2test -s -X ertm -P 4113 -U <bdaddr>
> +TC_CMC_BV_12_C         INC     l2test -s -X ertm -P 4113 -U <bdaddr>
> +                               JIRA #BA-77
> +TC_CMC_BV_13_C         INC     l2test -s -X ertm -P 4113 -U <bdaddr>
> +                               JIRA #BA-78
>  TC_CMC_BV_14_C         PASS    l2test -r -X streaming -P 4113
>  TC_CMC_BV_15_C         PASS    l2test -r -X streaming -P 4113
>  TC_CMC_BI_01_C         PASS    l2test -r -X ertm -P 4113
> @@ -71,10 +73,9 @@ TC_CMC_BI_06_C               PASS    l2test -r -P 4113
>  TC_FOC_BV_01_C         PASS    l2test -r -X ertm -P 4113 -F 0
>  TC_FOC_BV_02_C         PASS    l2test -r -X ertm -P 4113 -F 0
>  TC_FOC_BV_03_C         PASS    l2test -r -X ertm -P 4113 -F 0
> -TC_FOC_BV_04_C         PASS    l2test -r -X ertm -P 4113 -F 0
> -TC_OFS_BV_01_C         PASS    l2test -x -X ertm -P 4113 -F 0 N 1
> +TC_OFS_BV_01_C         PASS    l2test -x -X ertm -P 4113 -F 0 -N 1
>  TC_OFS_BV_02_C         PASS    l2test -r -X ertm -P 4113 -F 0
> -TC_OFS_BV_03_C         PASS    l2test -r -X streaming -P 4113 -F 0
> +TC_OFS_BV_03_C         PASS    l2test -x -X streaming -P 4113 -F 0 -N 1
>  TC_OFS_BV_04_C         PASS    l2test -r -X streaming -P 4113 -F 0
>  TC_OFS_BV_05_C         PASS    l2test -x -X ertm -P 4113 -N 1
>  TC_OFS_BV_06_C         PASS    l2test -r -X ertm -P 4113
> @@ -85,31 +86,34 @@ TC_ERM_BV_02_C              PASS    l2test -r -X ertm -P 4113
>  TC_ERM_BV_03_C         PASS    l2test -r -X ertm -P 4113
>  TC_ERM_BV_05_C         PASS    l2test -x -X ertm -P 4113 -N 2 -Y 2
>  TC_ERM_BV_06_C         PASS    l2test -x -X ertm -P 4113 -N 2 -Y 2
> -TC_ERM_BV_07_C         PASS    l2test -X ertm -P 4113
> +TC_ERM_BV_07_C         INC     l2test -X ertm -P 4113
> +                               JIRA #BA-79
>  TC_ERM_BV_08_C         PASS    l2test -x -X ertm -P 4113 -N 1
>  TC_ERM_BV_09_C         PASS    l2test -X ertm -P 4113
>  TC_ERM_BV_10_C         PASS    l2test -x -X ertm -P 4113 -N 1
>  TC_ERM_BV_11_C         PASS    l2test -x -X ertm -P 4113 -N 1 -Q 1
>  TC_ERM_BV_12_C         PASS    l2test -x -X ertm -P 4113 -R -N 1 -Q 1
> -TC_ERM_BV_13_C         PASS
> -TC_ERM_BV_14_C         PASS
> -TC_ERM_BV_15_C         PASS    l2test -X ertm -P 4113 -N 4 -Y 4
> +TC_ERM_BV_13_C         INC     JIRA #BA-80
> +TC_ERM_BV_14_C         INC     JIRA #BA-81
> +TC_ERM_BV_15_C         INC     l2test -X ertm -P 4113 -N 4 -Y 4
>  TC_ERM_BV_16_C         N/A
>  TC_ERM_BV_17_C         PASS    l2test -X ertm -P 4113
> -TC_ERM_BV_18_C         PASS
> -TC_ERM_BV_19_C         PASS    l2test -x -X ertm -P 4113 -N 1
> +TC_ERM_BV_18_C         INC     JIRA #BA-82
> +TC_ERM_NV_19_C         INC     JIRA #BA-83
>  TC_ERM_BV_20_C         PASS    l2test -x -X ertm -P 4113 -N 1
> -TC_ERM_BV_21_C         PASS    l2test -w -X ertm -P 4113 -N 3
> -TC_ERM_BV_22_C         PASS
> -TC_ERM_BV_23_C         PASS
> +TC_ERM_BV_21_C         INC     l2test -w -X ertm -P 4113 -N 3
> +                               JIRA #BA-84
> +TC_ERM_BV_22_C         INC     JIRA #BA-85
> +TC_ERM_BV_23_C         INC     JIRA #BA-86
>  TC_ERM_BI_01_C         N/A
>  TC_ERM_BI_02_C         PASS    l2test -X ertm -P 4113
> -TC_ERM_BI_03_C         PASS
> -TC_ERM_BI_04_C         PASS
> -TC_ERM_BI_05_C         PASS
> +TC_ERM_BI_03_C         INC     l2test -w -X ertm -P 4113 -N 2
> +                               JIRA #BA-87
> +TC_ERM_BI_04_C         INC     JIRA #BA-88
> +TC_ERM_BI_05_C         INC     JIRA #BA-89
>  TC_STM_BV_01_C         PASS    l2test -x -X streaming -P 4113 -N 3 -Y 3
>  TC_STM_BV_02_C         PASS    l2test -r -X streaming -P 4113
> -TC_STM_BV_03_C         PASS
> +TC_STM_BV_03_C         INC     JIRA #BA-76
>  TC_STM_BV_11_C         N/A
>  TC_STM_BV_12_C         N/A
>  TC_STM_BV_13_C         N/A
> @@ -142,9 +146,12 @@ TC_ECF_BV_05_C             N/A
>  TC_ECF_BV_06_C         N/A
>  TC_ECF_BV_07_C         N/A
>  TC_ECF_BV_08_C         N/A
> -TC_LE_CPU_BV_01_C      PASS    l2test -r -V le_public -J 4
> -TC_LE_CPU_BV_02_C      PASS    l2test -n -V le_public -J 4 <braddr>
> -TC_LE_CPU_BI_01_C      PASS    l2test -n -V le_public -J 4 <braddr>
> +                               NOTE: add some notes; daemon should be stopped
> +                               hciattach
> +TC_LE_CPU_BV_01_C      INC     l2test -r -V le_public -J 4
> +                               JIRA #BA-75
> +TC_LE_CPU_BV_02_C      INC     l2test -n -V le_public -J 4 <braddr>
> +TC_LE_CPU_BI_01_C      INC     l2test -n -V le_public -J 4 <braddr>
>  TC_LE_CPU_BI_02_C      INC     PTS issue #12339
>                                 l2test -r -V le_public -J 4
> -TC_LE_REJ_BV_01_C      PASS    l2test -n -V le_public -J 4 <braddr>
> +TC_LE_REJ_BV_01_C      INC     l2test -n -V le_public -J 4 <braddr>

I think this patch is not valid anymore.  LE part is still working in
the same way as for PTS 5.1 as you also confirmed on IRC

BR
Lukasz
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
