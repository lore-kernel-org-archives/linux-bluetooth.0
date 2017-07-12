Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <059FABA9-CC68-4295-8391-C2EA7C202BC7@hella-gutmann.com>
References: <059FABA9-CC68-4295-8391-C2EA7C202BC7@hella-gutmann.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Jul 2017 11:28:27 +0300
Message-ID: <CABBYNZLwLUTH3by8OV_D2duq4N0Ma2dkZW4wwtbPb=tPSH1TfQ@mail.gmail.com>
Subject: Re: Quality issue with Bluetooth-SIG
To: Heiko Abraham <heiko.abraham@hella-gutmann.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiko,

On Wed, Jul 12, 2017 at 11:07 AM, Heiko Abraham
<heiko.abraham@hella-gutmann.com> wrote:
> Hi,
>
> if an new version of BlueZ is release, are any tests running on it?
>
> Currently I see, that BlueZ 5.43, 5.45 or 4.101 with different versions of Linux Kernel (3.8, 3.12, 3.18) all failed with the Bluetooth-SIG test.
> I only look for Bluetooth Classic and RFCOMM. (Problems with eRTM, L2CAP_DISCONNECT)

Could you please refer to the test case that is failing, here is the
list of RTM test and how to run them:

TC_ERM_BV_01_C PASS l2test -x -X ertm -P 4113 -N 3 -Y 3
TC_ERM_BV_02_C PASS l2test -r -X ertm -P 4113
TC_ERM_BV_03_C PASS l2test -r -X ertm -P 4113
TC_ERM_BV_05_C PASS l2test -x -X ertm -P 4113 -N 2 -Y 2
TC_ERM_BV_06_C PASS l2test -x -X ertm -P 4113 -N 2 -Y 2
TC_ERM_BV_07_C PASS l2test -r -H 1000 -K 10000 -X ertm -P 4113
TC_ERM_BV_08_C PASS l2test -x -X ertm -P 4113 -N 1
TC_ERM_BV_09_C PASS l2test -X ertm -P 4113
TC_ERM_BV_10_C PASS l2test -x -X ertm -P 4113 -N 1
TC_ERM_BV_11_C PASS l2test -x -X ertm -P 4113 -N 1 -Q 1
TC_ERM_BV_12_C PASS l2test -x -X ertm -P 4113 -R -N 1 -Q 1
TC_ERM_BV_13_C PASS l2test -x -X ertm -P 4113 -N 2
TC_ERM_BV_14_C PASS l2test -x -X ertm -P 4113 -N 4
TC_ERM_BV_15_C PASS l2test -x -X ertm -P 4113 -N 4
TC_ERM_BV_16_C N/A
TC_ERM_BV_17_C PASS l2test -X ertm -P 4113
TC_ERM_BV_18_C PASS l2test -x -X ertm -P 4113 -N 1
TC_ERM_BV_19_C PASS l2test -x -X ertm -P 4113 -N 1
TC_ERM_BV_20_C PASS l2test -x -X ertm -P 4113 -N 1
TC_ERM_BV_21_C PASS l2test -x -X ertm -P 4113 -D 2000 -N 2
TC_ERM_BV_22_C PASS l2test -r -H 1000 -K 10000 -X ertm -P 4113
TC_ERM_BV_23_C PASS l2test -x -X ertm -P 4113 -N 2
TC_ERM_BI_01_C N/A
TC_ERM_BI_02_C PASS l2test -X ertm -P 4113
TC_ERM_BI_03_C PASS l2test -x -X ertm -P 4113 -N 2
TC_ERM_BI_04_C PASS l2test -x -X ertm -P 4113 -N 2
TC_ERM_BI_05_C PASS l2test -x -X ertm -P 4113 -N 2

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pts-l2cap.txt

PICS and PIXIT:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pics-l2cap.txt
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/android/pixit-l2cap.txt

> My assumption is, that a lot of Mainline LTS kernels not pass the Bluetooth-SIG by default.
> Any suggestions for the best kernel/BlueZ combinations? An newer Kernel like 4.x sometimes not possible (OpenGL ES support).
>
>
> Regards,
> Heiko Abraham
>
> --
>
> ________________________________
>
> --
> Hella Gutmann Solutions GmbH * Unternehmensform: Gesellschaft mit beschraenkter Haftung *
> Firmensitz: 79241 Ihringen * Eingetragen im Handelsregister: AG Freiburg i.Br., HRB 290194 * Geschaeftsfuehrer: Andreas Habeck * USt-IdNr.: DE142208666
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
