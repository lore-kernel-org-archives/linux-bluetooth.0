Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: 'Andrei Emeltchenko' <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <014f01cf8a1f$6b1c74c0$41555e40$@samsung.com>
 <20140617114548.GB621@aemeltch-MOBL1>
 <015801cf8a29$8660b250$932216f0$@samsung.com>
 <20140617124544.GC621@aemeltch-MOBL1>
In-reply-to: <20140617124544.GC621@aemeltch-MOBL1>
Subject: RE: Android AOSP source tree downloading fails
Date: Wed, 18 Jun 2014 12:27:20 +0530
Message-id: <015b01cf8ac2$92330760$b6991620$@samsung.com>
MIME-version: 1.0
Content-type: multipart/mixed;
 boundary="----=_NextPart_000_015C_01CF8AF0.ABF184F0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_015C_01CF8AF0.ABF184F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrei,

>-----Original Message-----
>From: 'Andrei Emeltchenko' [mailto:andrei.emeltchenko.news@gmail.com] 
>Sent: Tuesday, June 17, 2014 6:16 PM
>To: Vikrampal
>Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
>Subject: Re: Android AOSP source tree downloading fails
>
>Hi Vikram,
>
>On Tue, Jun 17, 2014 at 06:11:29PM +0530, Vikrampal wrote:
>> Hi Andrei,
>> 
>> >-----Original Message-----
>> >From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
>> >Sent: Tuesday, June 17, 2014 5:16 PM
>> >To: Vikrampal
>> >Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
>> >Subject: Re: Android AOSP source tree downloading fails
>> >
>> >Hi Vikram,
>> >
>> >On Tue, Jun 17, 2014 at 04:59:28PM +0530, Vikrampal wrote:
>> >> Hi,
>> >> 
>> >> I'm trying to download full Android AOSP source tree. I tried 2
methods:
>> >> 1) repo init -u https://code.google.com/p/aosp-bluez.platform-manifest

>> >> -b kitkat
>> >>      repo sync
>> >> error: Exited sync due to fetch errors
>> >
>> >Which project it cannot fetch?
>> >
>> >Best regards
>> >Andrei Emeltchenko 
>> 
>> platform/packages/apps/PackageInstaller
>> 
>
>Something wrong with proxies?
>
>$ repo sync platform/packages/apps/PackageInstaller
>Fetching project platform/packages/apps/PackageInstaller
>Fetching projects: 100% (1/1), done.  
>
>Best regards 
>Andrei Emeltchenko 

Perhaps, I didn't understand the problem. PFA the log file.

Regards,
Vikram

------=_NextPart_000_015C_01CF8AF0.ABF184F0
Content-Type: application/octet-stream;
	name="AOSP_download_error.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="AOSP_download_error.log"

error: cannot run /usr/local/bin/git-proxy: No such file or directory=0A=
fatal: cannot start proxy /usr/local/bin/git-proxy=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:-- =
--:--:-- --:--:--     0  % Total    % Received % Xferd  Average Speed   =
Time    Time     Time  Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D100     1  100     1    0     0      2      0 --:--:-- =
--:--:-- --:--:--     2=0A=
=0D100     1  100     1    0     0      2      0 --:--:-- --:--:-- =
--:--:--     2=0A=
=0D  0  552k    0  3275    0     0   2889      0  0:03:15  0:00:01  =
0:03:14  2889=0D100  552k  100  552k    0     0   480k      0  0:00:01  =
0:00:01 --:--:-- 35.7M=0A=
>From =
/home/vikram.p/android/.repo/projects/external/libsepol.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.2_pre3 -> android-4.2_pre3=0A=
 * [new tag]         android-4.2_pre2.2 -> android-4.2_pre2.2=0A=
 * [new tag]         android-4.2_pre2.1 -> android-4.2_pre2.1=0A=
 * [new tag]         android-4.2_pre2 -> android-4.2_pre2=0A=
 * [new tag]         android-4.2_pre1.1 -> android-4.2_pre1.1=0A=
 * [new tag]         android-4.2_pre1 -> android-4.2_pre1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.1_pre2 -> android-4.1_pre2=0A=
 * [new tag]         android-4.1_pre1 -> android-4.1_pre1=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.1-sdk_pre1 -> android-4.1-sdk_pre1=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:01 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:02 --:--:--     0From =
https://android.googlesource.com/platform/external/libsepol=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-factory-release -> =
aosp/jb-mr1-factory-release=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
   dedcd59..c71644b  master     -> aosp/master=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:-- =
--:--:-- --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:-- --:--:-- --:--:--     0=0A=
curl: (22) The requested URL returned error: 404 Not Found=0A=
Server does not provide clone.bundle; ignoring.=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:03 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:04 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:05 --:--:--     0=0D  0     0    0     0    0     0      =
0      0 --:--:--  0:00:06 --:--:--     0=0D  0     0    0     0    0    =
 0      0      0 --:--:--  0:00:07 --:--:--     0=0D  0     0    0     0 =
   0     0      0      0 --:--:--  0:00:08 --:--:--     0=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:09 --:--:--     0From =
https://android.googlesource.com/platform/external/strace=0A=
 * [new branch]      donut-release -> aosp/donut-release=0A=
 * [new branch]      donut-release2 -> aosp/donut-release2=0A=
 * [new branch]      eclair-passion-release -> =
aosp/eclair-passion-release=0A=
 * [new branch]      eclair-release -> aosp/eclair-release=0A=
 * [new branch]      eclair-sholes-release -> aosp/eclair-sholes-release=0A=
 * [new branch]      eclair-sholes-release2 -> =
aosp/eclair-sholes-release2=0A=
 * [new branch]      froyo      -> aosp/froyo=0A=
 * [new branch]      froyo-release -> aosp/froyo-release=0A=
 * [new branch]      gingerbread -> aosp/gingerbread=0A=
 * [new branch]      gingerbread-mr4-release -> =
aosp/gingerbread-mr4-release=0A=
 * [new branch]      gingerbread-release -> aosp/gingerbread-release=0A=
 * [new branch]      ics-factoryrom-2-release -> =
aosp/ics-factoryrom-2-release=0A=
 * [new branch]      ics-mr0    -> aosp/ics-mr0=0A=
 * [new branch]      ics-mr0-release -> aosp/ics-mr0-release=0A=
 * [new branch]      ics-mr1    -> aosp/ics-mr1=0A=
 * [new branch]      ics-mr1-release -> aosp/ics-mr1-release=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-1.6_r1 -> android-1.6_r1=0A=
 * [new tag]         android-1.6_r1.1 -> android-1.6_r1.1=0A=
 * [new tag]         android-1.6_r1.2 -> android-1.6_r1.2=0A=
 * [new tag]         android-1.6_r1.3 -> android-1.6_r1.3=0A=
 * [new tag]         android-1.6_r1.4 -> android-1.6_r1.4=0A=
 * [new tag]         android-1.6_r1.5 -> android-1.6_r1.5=0A=
 * [new tag]         android-1.6_r2 -> android-1.6_r2=0A=
 * [new tag]         android-2.0.1_r1 -> android-2.0.1_r1=0A=
 * [new tag]         android-2.0_r1 -> android-2.0_r1=0A=
 * [new tag]         android-2.1_r1 -> android-2.1_r1=0A=
 * [new tag]         android-2.1_r2 -> android-2.1_r2=0A=
 * [new tag]         android-2.1_r2.1p -> android-2.1_r2.1p=0A=
 * [new tag]         android-2.1_r2.1p2 -> android-2.1_r2.1p2=0A=
 * [new tag]         android-2.1_r2.1s -> android-2.1_r2.1s=0A=
 * [new tag]         android-2.2.1_r1 -> android-2.2.1_r1=0A=
 * [new tag]         android-2.2.1_r2 -> android-2.2.1_r2=0A=
 * [new tag]         android-2.2.2_r1 -> android-2.2.2_r1=0A=
 * [new tag]         android-2.2.3_r1 -> android-2.2.3_r1=0A=
 * [new tag]         android-2.2.3_r2 -> android-2.2.3_r2=0A=
 * [new tag]         android-2.2.3_r2.1 -> android-2.2.3_r2.1=0A=
 * [new tag]         android-2.2_r1 -> android-2.2_r1=0A=
 * [new tag]         android-2.2_r1.1 -> android-2.2_r1.1=0A=
 * [new tag]         android-2.2_r1.2 -> android-2.2_r1.2=0A=
 * [new tag]         android-2.2_r1.3 -> android-2.2_r1.3=0A=
 * [new tag]         android-2.3.1_r1 -> android-2.3.1_r1=0A=
 * [new tag]         android-2.3.2_r1 -> android-2.3.2_r1=0A=
 * [new tag]         android-2.3.3_r1 -> android-2.3.3_r1=0A=
 * [new tag]         android-2.3.3_r1.1 -> android-2.3.3_r1.1=0A=
 * [new tag]         android-2.3.4_r0.9 -> android-2.3.4_r0.9=0A=
 * [new tag]         android-2.3.4_r1 -> android-2.3.4_r1=0A=
 * [new tag]         android-2.3.5_r1 -> android-2.3.5_r1=0A=
 * [new tag]         android-2.3.6_r0.9 -> android-2.3.6_r0.9=0A=
 * [new tag]         android-2.3.6_r1 -> android-2.3.6_r1=0A=
 * [new tag]         android-2.3.7_r1 -> android-2.3.7_r1=0A=
 * [new tag]         android-2.3_r1 -> android-2.3_r1=0A=
 * [new tag]         android-4.0.1_r1 -> android-4.0.1_r1=0A=
 * [new tag]         android-4.0.1_r1.1 -> android-4.0.1_r1.1=0A=
 * [new tag]         android-4.0.1_r1.2 -> android-4.0.1_r1.2=0A=
 * [new tag]         android-4.0.2_r1 -> android-4.0.2_r1=0A=
 * [new tag]         android-4.0.3_r1 -> android-4.0.3_r1=0A=
 * [new tag]         android-4.0.3_r1.1 -> android-4.0.3_r1.1=0A=
 * [new tag]         android-4.0.4_r1 -> android-4.0.4_r1=0A=
 * [new tag]         android-4.0.4_r1.1 -> android-4.0.4_r1.1=0A=
 * [new tag]         android-4.0.4_r1.2 -> android-4.0.4_r1.2=0A=
 * [new tag]         android-4.0.4_r2 -> android-4.0.4_r2=0A=
 * [new tag]         android-4.0.4_r2.1 -> android-4.0.4_r2.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-2.2_r8 -> android-cts-2.2_r8=0A=
 * [new tag]         android-cts-2.3_r10 -> android-cts-2.3_r10=0A=
 * [new tag]         android-cts-2.3_r11 -> android-cts-2.3_r11=0A=
 * [new tag]         android-cts-2.3_r12 -> android-cts-2.3_r12=0A=
 * [new tag]         android-cts-4.0.3_r1 -> android-cts-4.0.3_r1=0A=
 * [new tag]         android-cts-4.0.3_r2 -> android-cts-4.0.3_r2=0A=
 * [new tag]         android-cts-4.0_r1 -> android-cts-4.0_r1=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-cts-verifier-4.0.3_r1 -> =
android-cts-verifier-4.0.3_r1=0A=
 * [new tag]         android-cts-verifier-4.0_r1 -> =
android-cts-verifier-4.0_r1=0A=
 * [new tag]         android-sdk-4.0.3-tools_r1 -> =
android-sdk-4.0.3-tools_r1=0A=
 * [new tag]         android-sdk-4.0.3_r1 -> android-sdk-4.0.3_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
 * [new tag]         android-sdk-adt_r16.0.1 -> android-sdk-adt_r16.0.1=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:10 --:--:--     0=0D100     1  100     1    0     0      2      0 =
--:--:-- --:--:-- --:--:--     2=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:11 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:01 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:02 --:--:--     0=0D  0     0    0     0    0     0      =
0      0 --:--:--  0:00:02 --:--:--     0=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:12 =
--:--:--     0=0D  0  167M    0  1348    0     0    473      0   4d 06h  =
0:00:02   4d 06h   473=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:13 --:--:--     0=0D  1  167M    1 1869k    0     0   =
490k      0  0:05:49  0:00:03  0:05:46 1929k=0D  0     0    0     0    0 =
    0      0      0 --:--:--  0:00:14 --:--:--     0=0D  2  167M    2 =
3737k    0     0   776k      0  0:03:40  0:00:04  0:03:36 1901k=0D  0    =
 0    0     0    0     0      0      0 --:--:--  0:00:15 --:--:--     =
0=0D  3  167M    3 5226k    0     0   898k      0  0:03:10  0:00:05  =
0:03:05 1759k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:16 --:--:--     0=0D  3  167M    3 6718k    0     0   985k      0  =
0:02:53  0:00:06  0:02:47 1692k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:17 --:--:--     0=0D  4  167M    4 7920k    0     =
0  1012k      0  0:02:49  0:00:07  0:02:42 1592kFrom =
https://android.googlesource.com/platform/external/chromium_org/third_par=
ty/angle_dx11=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
 * [new tag]         chromium_org-pre-replication -> =
chromium_org-pre-replication=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:18 --:--:--     0=0D100     1  100     1    0     0      2      0 =
--:--:-- --:--:-- --:--:--     2=0A=
=0D  5  167M    5 9535k    0     0  1081k      0  0:02:38  0:00:08  =
0:02:30 1532k=0D  0     0    0     0    0     0      0      0 --:--:-- =
--:--:-- --:--:--     0=0D100  320k  100  320k    0     0   377k      0 =
--:--:-- --:--:-- --:--:-- 1558k=0A=
>From =
/home/vikram.p/android/.repo/projects/packages/wallpapers/PhaseBeam.git/c=
lone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-sdk-adt_r16.0.1 -> android-sdk-adt_r16.0.1=0A=
 * [new tag]         android-sdk-4.0.3_r1 -> android-sdk-4.0.3_r1=0A=
 * [new tag]         android-sdk-4.0.3-tools_r1 -> =
android-sdk-4.0.3-tools_r1=0A=
 * [new tag]         android-cts-verifier-4.0_r1 -> =
android-cts-verifier-4.0_r1=0A=
 * [new tag]         android-cts-verifier-4.0.3_r1 -> =
android-cts-verifier-4.0.3_r1=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-cts-4.0_r1 -> android-cts-4.0_r1=0A=
 * [new tag]         android-cts-4.0.3_r2 -> android-cts-4.0.3_r2=0A=
 * [new tag]         android-cts-4.0.3_r1 -> android-cts-4.0.3_r1=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.0.4_r2.1 -> android-4.0.4_r2.1=0A=
 * [new tag]         android-4.0.4_r2 -> android-4.0.4_r2=0A=
 * [new tag]         android-4.0.4_r1.2 -> android-4.0.4_r1.2=0A=
 * [new tag]         android-4.0.4_r1.1 -> android-4.0.4_r1.1=0A=
 * [new tag]         android-4.0.4_r1 -> android-4.0.4_r1=0A=
 * [new tag]         android-4.0.3_r1.1 -> android-4.0.3_r1.1=0A=
 * [new tag]         android-4.0.3_r1 -> android-4.0.3_r1=0A=
 * [new tag]         android-4.0.2_r1 -> android-4.0.2_r1=0A=
 * [new tag]         android-4.0.1_r1.2 -> android-4.0.1_r1.2=0A=
 * [new tag]         android-4.0.1_r1.1 -> android-4.0.1_r1.1=0A=
 * [new tag]         android-4.0.1_r1 -> android-4.0.1_r1=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:19 =
--:--:--     0=0D  6  167M    6 10.4M    0     0  1093k      0  0:02:36  =
0:00:09  0:02:27 1398k=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:20 --:--:--     0From =
https://android.googlesource.com/platform/packages/wallpapers/PhaseBeam=0A=
 * [new branch]      ics-factoryrom-2-release -> =
aosp/ics-factoryrom-2-release=0A=
 * [new branch]      ics-mr0    -> aosp/ics-mr0=0A=
 * [new branch]      ics-mr0-release -> aosp/ics-mr0-release=0A=
 * [new branch]      ics-mr1    -> aosp/ics-mr1=0A=
 * [new branch]      ics-mr1-release -> aosp/ics-mr1-release=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
   8743d10..0da76f3  master     -> aosp/master=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  6  167M    6 11.4M    0     0  1082k      0  0:02:38  =
0:00:10  0:02:28 1297k=0D  0     0    0     0    0     0      0      0 =
--:--:-- --:--:-- --:--:--     0=0D100     1  100     1    0     0      =
2      0 --:--:-- --:--:-- --:--:--     2=0A=
=0D100  236k  100  236k    0     0   311k      0 --:--:-- --:--:-- =
--:--:--  311k=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:21 =
--:--:--     0From =
/home/vikram.p/android/.repo/projects/external/mockito.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
=0D  7  167M    7 12.3M    0     0  1072k      0  0:02:39  0:00:11  =
0:02:28 1190k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:22 --:--:--     0From =
https://android.googlesource.com/platform/external/mockito=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
   34f80a9..4d0dcd5  master     -> aosp/master=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  8  167M    8 13.7M    0     0  1099k      0  0:02:35  =
0:00:12  0:02:23 1234k=0D  0     0    0     0    0     0      0      0 =
--:--:-- --:--:-- --:--:--     0=0D100     1  100     1    0     0      =
2      0 --:--:-- --:--:-- --:--:--     2=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:23 =
--:--:--     0=0D  9  167M    9 15.7M    0     0  1169k      0  0:02:26  =
0:00:13  0:02:13 1324k=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:24 --:--:--     0=0D  0     0    0     0    0     0      =
0      0 --:--:--  0:00:01 --:--:--     0=0D 10  167M   10 17.3M    0    =
 0  1201k      0  0:02:22  0:00:14  0:02:08 1412k=0D  0     0    0     0 =
   0     0      0      0 --:--:--  0:00:25 --:--:--     0=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0=0D 11  =
167M   11 19.4M    0     0  1257k      0  0:02:16  0:00:15  0:02:01 =
1636k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:26 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:03 --:--:--     0=0D 12  167M   12 21.5M    0     0  1314k      0  =
0:02:10  0:00:16  0:01:54 1886k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:27 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:04 --:--:--     0=0D 13  167M   13 23.1M  =
  0     0  1333k      0  0:02:08  0:00:17  0:01:51 1931k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:28 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:05 --:--:--     =
0=0D 14  167M   14 24.5M    0     0  1335k      0  0:02:08  0:00:18  =
0:01:50 1794k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:29 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:06 --:--:--     0=0D 15  167M   15 26.1M    0     0  =
1351k      0  0:02:06  0:00:19  0:01:47 1797k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:30 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:07 --:--:--     0=0D 16  =
167M   16 27.7M    0     0  1364k      0  0:02:05  0:00:20  0:01:45 =
1700k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:31 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:08 --:--:--     0=0D 17  167M   17 29.5M    0     0  1388k      0  =
0:02:03  0:00:21  0:01:42 1637k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:32 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:09 --:--:--     0=0D 18  167M   18 31.5M  =
  0     0  1415k      0  0:02:01  0:00:22  0:01:39 1707k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:33 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:10 --:--:--     =
0=0D 19  167M   19 33.0M    0     0  1420k      0  0:02:00  0:00:23  =
0:01:37 1740k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:34 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:11 --:--:--     0=0D 21  167M   21 35.2M    0     0  =
1453k      0  0:01:57  0:00:24  0:01:33 1858k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:35 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:12 --:--:--     0=0D 22  =
167M   22 37.2M    0     0  1479k      0  0:01:55  0:00:25  0:01:30 =
1957k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:36 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:13 --:--:--     0=0D 23  167M   23 39.1M    0     0  1495k      0  =
0:01:54  0:00:26  0:01:28 1961k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:37 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:14 --:--:--     0=0D 24  167M   24 40.8M  =
  0     0  1505k      0  0:01:53  0:00:27  0:01:26 1916k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:38 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:15 --:--:--     =
0=0D 25  167M   25 42.9M    0     0  1525k      0  0:01:52  0:00:28  =
0:01:24 2025kerror: cannot run /usr/local/bin/git-proxy: No such file or =
directory=0A=
fatal: cannot start proxy /usr/local/bin/git-proxy=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:39 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:16 --:--:--     0=0D 26  167M   26 44.7M    0     0  1538k      0  =
0:01:51  0:00:29  0:01:22 1957k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:40 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:17 --:--:--     0=0D 27  167M   27 46.8M  =
  0     0  1555k      0  0:01:50  0:00:30  0:01:20 1951k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:41 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:18 --:--:--     =
0=0D 29  167M   29 48.5M    0     0  1563k      0  0:01:49  0:00:31  =
0:01:18 1929k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:42 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:19 --:--:--     0=0D 30  167M   30 50.3M    0     0  =
1572k      0  0:01:48  0:00:32  0:01:16 1945k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:43 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:20 --:--:--     0=0D 31  =
167M   31 52.1M    0     0  1579k      0  0:01:48  0:00:33  0:01:15 =
1889k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:44 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:21 --:--:--     0=0D 32  167M   32 53.9M    0     0  1586k      0  =
0:01:47  0:00:34  0:01:13 1873k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:45 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:22 --:--:--     0=0D 33  167M   33 55.4M  =
  0     0  1586k      0  0:01:47  0:00:35  0:01:12 1777k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:46 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:23 --:--:--     =
0=0D 34  167M   34 57.5M    0     0  1600k      0  0:01:47  0:00:36  =
0:01:11 1835k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:47 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:24 --:--:--     0=0D 35  167M   35 59.4M    0     0  =
1608k      0  0:01:46  0:00:37  0:01:09 1847k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:48 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:25 --:--:--     0=0D 36  =
167M   36 61.0M    0     0  1610k      0  0:01:46  0:00:38  0:01:08 =
1821k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:49 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:26 --:--:--     0=0D 37  167M   37 62.9M    0     0  1619k      0  =
0:01:45  0:00:39  0:01:06 1848k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:50 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:27 --:--:--     0=0D 38  167M   38 64.4M  =
  0     0  1616k      0  0:01:45  0:00:40  0:01:05 1830k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:51 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:28 --:--:--     =
0=0D 39  167M   39 65.6M    0     0  1606k      0  0:01:46  0:00:41  =
0:01:05 1652k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:52 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:29 --:--:--     0=0D 39  167M   39 66.8M    0     0  =
1599k      0  0:01:47  0:00:42  0:01:05 1527k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:53 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:30 --:--:--     0=0D 40  =
167M   40 68.4M    0     0  1599k      0  0:01:47  0:00:43  0:01:04 =
1512k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:54 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:31 --:--:--     0=0D 42  167M   42 70.4M    0     0  1610k      0  =
0:01:46  0:00:44  0:01:02 1537k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:00:55 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:32 --:--:--     0=0D 43  167M   43 72.0M  =
  0     0  1609k      0  0:01:46  0:00:45  0:01:01 1553k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:00:56 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:33 --:--:--     =
0=0D 44  167M   44 73.5M    0     0  1609k      0  0:01:46  0:00:46  =
0:01:00 1636k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:57 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:34 --:--:--     0=0D 45  167M   45 75.6M    0     0  =
1620k      0  0:01:45  0:00:47  0:00:58 1801k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:00:58 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:35 --:--:--     0=0D 46  =
167M   46 77.5M    0     0  1625k      0  0:01:45  0:00:48  0:00:57 =
1858k=0D  0     0    0     0    0     0      0      0 --:--:--  0:00:59 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:36 --:--:--     0=0D 47  167M   47 79.0M    0     0  1626k      0  =
0:01:45  0:00:49  0:00:56 1767k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:00 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:37 --:--:--     0=0D 48  167M   48 80.6M  =
  0     0  1624k      0  0:01:45  0:00:50  0:00:55 1764k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:01 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:38 --:--:--     =
0=0D 49  167M   49 82.3M    0     0  1626k      0  0:01:45  0:00:51  =
0:00:54 1786k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:02 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:39 --:--:--     0=0D 50  167M   50 84.2M    0     0  =
1632k      0  0:01:44  0:00:52  0:00:52 1752k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:03 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:40 --:--:--     0=0D 51  =
167M   51 85.7M    0     0  1631k      0  0:01:44  0:00:53  0:00:51 =
1685k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:04 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:41 --:--:--     0=0D 52  167M   52 87.1M    0     0  1627k      0  =
0:01:45  0:00:54  0:00:51 1647k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:05 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:42 --:--:--     0=0D 52  167M   52 88.3M  =
  0     0  1621k      0  0:01:45  0:00:55  0:00:50 1587k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:06 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:43 --:--:--     =
0=0D 53  167M   53 89.8M    0     0  1618k      0  0:01:45  0:00:56  =
0:00:49 1531k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:07 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:44 --:--:--     0=0D 54  167M   54 90.7M    0     0  =
1607k      0  0:01:46  0:00:57  0:00:49 1341k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:08 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:45 --:--:--     0=0D 55  =
167M   55 92.1M    0     0  1604k      0  0:01:46  0:00:58  0:00:48 =
1311k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:09 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:46 --:--:--     0=0D 55  167M   55 93.6M    0     0  1603k      0  =
0:01:46  0:00:59  0:00:47 1329k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:10 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:47 --:--:--     0=0D 56  167M   56 94.9M  =
  0     0  1599k      0  0:01:47  0:01:00  0:00:47 1351kerror: Cannot =
fetch bluetooth/bluez=0A=
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  =
Current=0A=
                                 Dload  Upload   Total   Spent    Left  =
Speed=0A=
=0D  0     0    0     0    0     0      0      0 --:--:-- --:--:-- =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:11 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:48 --:--:--     0=0D100     1  100     1    0     0      =
2      0 --:--:-- --:--:-- --:--:--     2=0A=
=0D 57  167M   57 96.0M    0     0  1590k      0  0:01:47  0:01:01  =
0:00:46 1275k=0D  0     0    0     0    0     0      0      0 --:--:-- =
--:--:-- --:--:--     0=0D100  463k  100  463k    0     0   628k      0 =
--:--:-- --:--:-- --:--:-- 4032k=0A=
>From =
/home/vikram.p/android/.repo/projects/external/dnsmasq.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-sdk-adt_r16.0.1 -> android-sdk-adt_r16.0.1=0A=
 * [new tag]         android-sdk-4.0.3_r1 -> android-sdk-4.0.3_r1=0A=
 * [new tag]         android-sdk-4.0.3-tools_r1 -> =
android-sdk-4.0.3-tools_r1=0A=
 * [new tag]         android-cts-verifier-4.0_r1 -> =
android-cts-verifier-4.0_r1=0A=
 * [new tag]         android-cts-verifier-4.0.3_r1 -> =
android-cts-verifier-4.0.3_r1=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-cts-4.0_r1 -> android-cts-4.0_r1=0A=
 * [new tag]         android-cts-4.0.3_r2 -> android-cts-4.0.3_r2=0A=
 * [new tag]         android-cts-4.0.3_r1 -> android-cts-4.0.3_r1=0A=
 * [new tag]         android-cts-2.3_r12 -> android-cts-2.3_r12=0A=
 * [new tag]         android-cts-2.3_r11 -> android-cts-2.3_r11=0A=
 * [new tag]         android-cts-2.3_r10 -> android-cts-2.3_r10=0A=
 * [new tag]         android-cts-2.2_r8 -> android-cts-2.2_r8=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.2_pre3 -> android-4.2_pre3=0A=
 * [new tag]         android-4.2_pre2.2 -> android-4.2_pre2.2=0A=
 * [new tag]         android-4.2_pre2.1 -> android-4.2_pre2.1=0A=
 * [new tag]         android-4.2_pre2 -> android-4.2_pre2=0A=
 * [new tag]         android-4.2_pre1.1 -> android-4.2_pre1.1=0A=
 * [new tag]         android-4.2_pre1 -> android-4.2_pre1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.1_pre2 -> android-4.1_pre2=0A=
 * [new tag]         android-4.1_pre1 -> android-4.1_pre1=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.1-sdk_pre1 -> android-4.1-sdk_pre1=0A=
 * [new tag]         android-4.0.4_r2.1 -> android-4.0.4_r2.1=0A=
 * [new tag]         android-4.0.4_r2 -> android-4.0.4_r2=0A=
 * [new tag]         android-4.0.4_r1.2 -> android-4.0.4_r1.2=0A=
 * [new tag]         android-4.0.4_r1.1 -> android-4.0.4_r1.1=0A=
 * [new tag]         android-4.0.4_r1 -> android-4.0.4_r1=0A=
 * [new tag]         android-4.0.4-aah_r1 -> android-4.0.4-aah_r1=0A=
 * [new tag]         android-4.0.3_r1.1 -> android-4.0.3_r1.1=0A=
 * [new tag]         android-4.0.3_r1 -> android-4.0.3_r1=0A=
 * [new tag]         android-4.0.2_r1 -> android-4.0.2_r1=0A=
 * [new tag]         android-4.0.1_r1.2 -> android-4.0.1_r1.2=0A=
 * [new tag]         android-4.0.1_r1.1 -> android-4.0.1_r1.1=0A=
 * [new tag]         android-4.0.1_r1 -> android-4.0.1_r1=0A=
 * [new tag]         android-3.2_r1 -> android-3.2_r1=0A=
 * [new tag]         android-3.2.6_r1 -> android-3.2.6_r1=0A=
 * [new tag]         android-3.2.4_r1 -> android-3.2.4_r1=0A=
 * [new tag]         android-3.2.2_r2 -> android-3.2.2_r2=0A=
 * [new tag]         android-3.2.2_r1 -> android-3.2.2_r1=0A=
 * [new tag]         android-3.2.1_r2 -> android-3.2.1_r2=0A=
 * [new tag]         android-3.2.1_r1 -> android-3.2.1_r1=0A=
 * [new tag]         android-3.1_r1 -> android-3.1_r1=0A=
 * [new tag]         android-3.0_r1.3 -> android-3.0_r1.3=0A=
 * [new tag]         android-3.0_r1.2 -> android-3.0_r1.2=0A=
 * [new tag]         android-3.0_r1.1 -> android-3.0_r1.1=0A=
 * [new tag]         android-3.0_r1 -> android-3.0_r1=0A=
 * [new tag]         android-2.3_r1 -> android-2.3_r1=0A=
 * [new tag]         android-2.3.7_r1 -> android-2.3.7_r1=0A=
 * [new tag]         android-2.3.6_r1 -> android-2.3.6_r1=0A=
 * [new tag]         android-2.3.6_r0.9 -> android-2.3.6_r0.9=0A=
 * [new tag]         android-2.3.5_r1 -> android-2.3.5_r1=0A=
 * [new tag]         android-2.3.4_r1 -> android-2.3.4_r1=0A=
 * [new tag]         android-2.3.4_r0.9 -> android-2.3.4_r0.9=0A=
 * [new tag]         android-2.3.3_r1.1 -> android-2.3.3_r1.1=0A=
 * [new tag]         android-2.3.3_r1 -> android-2.3.3_r1=0A=
 * [new tag]         android-2.3.2_r1 -> android-2.3.2_r1=0A=
 * [new tag]         android-2.3.1_r1 -> android-2.3.1_r1=0A=
 * [new tag]         android-2.2_r1.3 -> android-2.2_r1.3=0A=
 * [new tag]         android-2.2_r1.2 -> android-2.2_r1.2=0A=
 * [new tag]         android-2.2_r1.1 -> android-2.2_r1.1=0A=
 * [new tag]         android-2.2_r1 -> android-2.2_r1=0A=
 * [new tag]         android-2.2.3_r2.1 -> android-2.2.3_r2.1=0A=
 * [new tag]         android-2.2.3_r2 -> android-2.2.3_r2=0A=
 * [new tag]         android-2.2.3_r1 -> android-2.2.3_r1=0A=
 * [new tag]         android-2.2.2_r1 -> android-2.2.2_r1=0A=
 * [new tag]         android-2.2.1_r2 -> android-2.2.1_r2=0A=
 * [new tag]         android-2.2.1_r1 -> android-2.2.1_r1=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:12 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:49 --:--:--     0=0D 58  167M   58 97.2M    0     0  1584k      0  =
0:01:48  0:01:02  0:00:46 1320kFrom =
https://android.googlesource.com/platform/external/dnsmasq=0A=
 * [new branch]      froyo      -> aosp/froyo=0A=
 * [new branch]      froyo-release -> aosp/froyo-release=0A=
 * [new branch]      gingerbread -> aosp/gingerbread=0A=
 * [new branch]      gingerbread-mr4-release -> =
aosp/gingerbread-mr4-release=0A=
 * [new branch]      gingerbread-release -> aosp/gingerbread-release=0A=
 * [new branch]      ics-aah-release -> aosp/ics-aah-release=0A=
 * [new branch]      ics-factoryrom-2-release -> =
aosp/ics-factoryrom-2-release=0A=
 * [new branch]      ics-mr0    -> aosp/ics-mr0=0A=
 * [new branch]      ics-mr0-release -> aosp/ics-mr0-release=0A=
 * [new branch]      ics-mr1    -> aosp/ics-mr1=0A=
 * [new branch]      ics-mr1-release -> aosp/ics-mr1-release=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-factory-release -> =
aosp/jb-mr1-factory-release=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:13 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:50 --:--:--     0=0D 58  167M   58 98.3M    0     0  1577k      0  =
0:01:48  0:01:03  0:00:45 1265k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:14 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:51 --:--:--     0=0D 59  167M   59 99.8M  =
  0     0  1577k      0  0:01:48  0:01:04  0:00:44 1277k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:15 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:52 --:--:--     =
0=0D 60  167M   60  101M    0     0  1580k      0  0:01:48  0:01:05  =
0:00:43 1349k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:16 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:53 --:--:--     0=0D 61  167M   61  103M    0     0  =
1580k      0  0:01:48  0:01:06  0:00:42 1457k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:17 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:54 --:--:--     0=0D 62  =
167M   62  103M    0     0  1569k      0  0:01:49  0:01:07  0:00:42 =
1374k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:18 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:00:55 --:--:--     0=0D 62  167M   62  104M    0     0  1561k      0  =
0:01:49  0:01:08  0:00:41 1348k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:19 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:00:56 --:--:--     0=0D 63  167M   63  106M  =
  0     0  1565k      0  0:01:49  0:01:09  0:00:40 1403k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:20 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:00:57 --:--:--     =
0=0D 64  167M   64  108M    0     0  1571k      0  0:01:49  0:01:10  =
0:00:39 1450k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:21 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:00:58 --:--:--     0=0D 66  167M   66  110M    0     0  =
1577k      0  0:01:48  0:01:11  0:00:37 1528k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:22 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:00:59 --:--:--     0=0D 66  =
167M   66  111M    0     0  1570k      0  0:01:49  0:01:12  0:00:37 =
1587k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:23 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:00 --:--:--     0=0D 67  167M   67  112M    0     0  1561k      0  =
0:01:49  0:01:13  0:00:36 1563k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:24 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:01 --:--:--     0=0D 68  167M   68  113M  =
  0     0  1556k      0  0:01:50  0:01:14  0:00:36 1438k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:25 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:02 --:--:--     =
0=0D 69  167M   69  115M    0     0  1561k      0  0:01:49  0:01:15  =
0:00:34 1428k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:26 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:03 --:--:--     0=0D 70  167M   70  117M    0     0  =
1562k      0  0:01:49  0:01:16  0:00:33 1347k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:27 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:04 --:--:--     0=0D 70  =
167M   70  118M    0     0  1562k      0  0:01:49  0:01:17  0:00:32 =
1448k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:28 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:05 --:--:--     0=0D 72  167M   72  120M    0     0  1568k      0  =
0:01:49  0:01:18  0:00:31 1684k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:29 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:06 --:--:--     0=0D 73  167M   73  122M  =
  0     0  1576k      0  0:01:48  0:01:19  0:00:29 1866k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:30 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:07 --:--:--     =
0=0D 74  167M   74  124M    0     0  1575k      0  0:01:48  0:01:20  =
0:00:28 1780k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:31 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:08 --:--:--     0=0D 75  167M   75  125M    0     0  =
1572k      0  0:01:48  0:01:21  0:00:27 1732k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:32 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:09 --:--:--     0=0D 75  =
167M   75  126M    0     0  1568k      0  0:01:49  0:01:22  0:00:27 =
1663k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:33 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:10 --:--:--     0=0D 76  167M   76  128M    0     0  1564k      0  =
0:01:49  0:01:23  0:00:26 1498k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:34 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:11 --:--:--     0=0D 77  167M   77  129M  =
  0     0  1559k      0  0:01:49  0:01:24  0:00:25 1285k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:35 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:12 --:--:--     =
0=0D 77  167M   77  130M    0     0  1556k      0  0:01:50  0:01:25  =
0:00:25 1254k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:36 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:13 --:--:--     0=0D 78  167M   78  132M    0     0  =
1557k      0  0:01:49  0:01:26  0:00:23 1313k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:37 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:14 --:--:--     0=0D 80  =
167M   80  133M    0     0  1561k      0  0:01:49  0:01:27  0:00:22 =
1437k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:38 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:15 --:--:--     0=0D 81  167M   81  135M    0     0  1564k      0  =
0:01:49  0:01:28  0:00:21 1551k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:39 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:16 --:--:--     0=0D 82  167M   82  137M  =
  0     0  1569k      0  0:01:49  0:01:29  0:00:20 1752k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:40 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:17 --:--:--     =
0=0D 83  167M   83  139M    0     0  1574k      0  0:01:48  0:01:30  =
0:00:18 1882k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:41 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:18 --:--:--     0=0D 84  167M   84  141M    0     0  =
1576k      0  0:01:48  0:01:31  0:00:17 1895k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:42 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:19 --:--:--     0=0D 85  =
167M   85  142M    0     0  1574k      0  0:01:48  0:01:32  0:00:16 =
1811k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:43 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:20 --:--:--     0=0D 85  167M   85  143M    0     0  1568k      0  =
0:01:49  0:01:33  0:00:16 1640k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:44 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:21 --:--:--     0=0D 86  167M   86  144M  =
  0     0  1557k      0  0:01:49  0:01:34  0:00:15 1335k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:45 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:22 --:--:--     =
0=0D 86  167M   86  144M    0     0  1549k      0  0:01:50  0:01:35  =
0:00:15 1090k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:46 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:23 --:--:--     0=0D 87  167M   87  145M    0     0  =
1543k      0  0:01:50  0:01:36  0:00:14  949k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:47 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:24 --:--:--     0=0D 88  =
167M   88  147M    0     0  1542k      0  0:01:51  0:01:37  0:00:14  =
934k=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:48 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:25 --:--:--     0=0D 88  167M   88  148M    0     0  1539k      0  =
0:01:51  0:01:38  0:00:13  993k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:49 --:--:--     0=0D  0     0    0     0    0     =
0      0      0 --:--:--  0:01:26 --:--:--     0=0D 89  167M   89  149M  =
  0     0  1537k      0  0:01:51  0:01:39  0:00:12 1157k=0D  0     0    =
0     0    0     0      0      0 --:--:--  0:01:50 --:--:--     0=0D  0  =
   0    0     0    0     0      0      0 --:--:--  0:01:27 --:--:--     =
0=0D 90  167M   90  151M    0     0  1537k      0  0:01:51  0:01:40  =
0:00:11 1310k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:51 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:28 --:--:--     0=0D 91  167M   91  153M    0     0  =
1540k      0  0:01:51  0:01:41  0:00:10 1474k=0D  0     0    0     0    =
0     0      0      0 --:--:--  0:01:52 --:--:--     0=0D  0     0    0  =
   0    0     0      0      0 --:--:--  0:01:29 --:--:--     0=0D 92  =
167M   92  154M    0     0  1540k      0  0:01:51  0:01:42  0:00:09 =
1506k=0D  0 28.4M    0  2696    0     0     29      0  11d 21h  0:01:30  =
11d 21h   545=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:53 --:--:--     0=0D 45 28.4M   45 13.0M    0     0   146k      0  =
0:03:18  0:01:31  0:01:47 3067k=0D 93  167M   93  156M    0     0  1541k =
     0  0:01:51  0:01:43  0:00:08 1590k=0D100 28.4M  100 28.4M    0     =
0   317k      0  0:01:31  0:01:31 --:--:-- 7580k=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:01:54 =
--:--:--     0=0D 94  167M   94  157M    0     0  1539k      0  0:01:51  =
0:01:44  0:00:07 1587k=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:01:55 --:--:--     0From =
/home/vikram.p/android/.repo/projects/external/svox.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-sdk-adt_r16.0.1 -> android-sdk-adt_r16.0.1=0A=
 * [new tag]         android-sdk-4.0.3_r1 -> android-sdk-4.0.3_r1=0A=
 * [new tag]         android-sdk-4.0.3-tools_r1 -> =
android-sdk-4.0.3-tools_r1=0A=
 * [new tag]         android-cts-verifier-4.0_r1 -> =
android-cts-verifier-4.0_r1=0A=
 * [new tag]         android-cts-verifier-4.0.3_r1 -> =
android-cts-verifier-4.0.3_r1=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-cts-4.0_r1 -> android-cts-4.0_r1=0A=
 * [new tag]         android-cts-4.0.3_r2 -> android-cts-4.0.3_r2=0A=
 * [new tag]         android-cts-4.0.3_r1 -> android-cts-4.0.3_r1=0A=
 * [new tag]         android-cts-2.3_r12 -> android-cts-2.3_r12=0A=
 * [new tag]         android-cts-2.3_r11 -> android-cts-2.3_r11=0A=
 * [new tag]         android-cts-2.3_r10 -> android-cts-2.3_r10=0A=
 * [new tag]         android-cts-2.2_r8 -> android-cts-2.2_r8=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.0.4_r2.1 -> android-4.0.4_r2.1=0A=
 * [new tag]         android-4.0.4_r2 -> android-4.0.4_r2=0A=
 * [new tag]         android-4.0.4_r1.2 -> android-4.0.4_r1.2=0A=
 * [new tag]         android-4.0.4_r1.1 -> android-4.0.4_r1.1=0A=
 * [new tag]         android-4.0.4_r1 -> android-4.0.4_r1=0A=
 * [new tag]         android-4.0.3_r1.1 -> android-4.0.3_r1.1=0A=
 * [new tag]         android-4.0.3_r1 -> android-4.0.3_r1=0A=
 * [new tag]         android-4.0.2_r1 -> android-4.0.2_r1=0A=
 * [new tag]         android-4.0.1_r1.2 -> android-4.0.1_r1.2=0A=
 * [new tag]         android-4.0.1_r1.1 -> android-4.0.1_r1.1=0A=
 * [new tag]         android-4.0.1_r1 -> android-4.0.1_r1=0A=
 * [new tag]         android-2.3_r1 -> android-2.3_r1=0A=
 * [new tag]         android-2.3.7_r1 -> android-2.3.7_r1=0A=
 * [new tag]         android-2.3.6_r1 -> android-2.3.6_r1=0A=
 * [new tag]         android-2.3.6_r0.9 -> android-2.3.6_r0.9=0A=
 * [new tag]         android-2.3.5_r1 -> android-2.3.5_r1=0A=
 * [new tag]         android-2.3.4_r1 -> android-2.3.4_r1=0A=
 * [new tag]         android-2.3.4_r0.9 -> android-2.3.4_r0.9=0A=
 * [new tag]         android-2.3.3_r1.1 -> android-2.3.3_r1.1=0A=
 * [new tag]         android-2.3.3_r1 -> android-2.3.3_r1=0A=
 * [new tag]         android-2.3.2_r1 -> android-2.3.2_r1=0A=
 * [new tag]         android-2.3.1_r1 -> android-2.3.1_r1=0A=
 * [new tag]         android-2.2_r1.3 -> android-2.2_r1.3=0A=
 * [new tag]         android-2.2_r1.2 -> android-2.2_r1.2=0A=
 * [new tag]         android-2.2_r1.1 -> android-2.2_r1.1=0A=
 * [new tag]         android-2.2_r1 -> android-2.2_r1=0A=
 * [new tag]         android-2.2.3_r2.1 -> android-2.2.3_r2.1=0A=
 * [new tag]         android-2.2.3_r2 -> android-2.2.3_r2=0A=
 * [new tag]         android-2.2.3_r1 -> android-2.2.3_r1=0A=
 * [new tag]         android-2.2.2_r1 -> android-2.2.2_r1=0A=
 * [new tag]         android-2.2.1_r2 -> android-2.2.1_r2=0A=
 * [new tag]         android-2.2.1_r1 -> android-2.2.1_r1=0A=
 * [new tag]         android-2.1_r2.1s -> android-2.1_r2.1s=0A=
 * [new tag]         android-2.1_r2.1p2 -> android-2.1_r2.1p2=0A=
 * [new tag]         android-2.1_r2.1p -> android-2.1_r2.1p=0A=
 * [new tag]         android-2.1_r2 -> android-2.1_r2=0A=
 * [new tag]         android-2.1_r1 -> android-2.1_r1=0A=
 * [new tag]         android-2.0_r1 -> android-2.0_r1=0A=
 * [new tag]         android-2.0.1_r1 -> android-2.0.1_r1=0A=
 * [new tag]         android-1.6_r2 -> android-1.6_r2=0A=
 * [new tag]         android-1.6_r1.5 -> android-1.6_r1.5=0A=
 * [new tag]         android-1.6_r1.4 -> android-1.6_r1.4=0A=
 * [new tag]         android-1.6_r1.3 -> android-1.6_r1.3=0A=
 * [new tag]         android-1.6_r1.2 -> android-1.6_r1.2=0A=
 * [new tag]         android-1.6_r1.1 -> android-1.6_r1.1=0A=
 * [new tag]         android-1.6_r1 -> android-1.6_r1=0A=
=0D 95  167M   95  159M    0     0  1541k      0  0:01:51  0:01:45  =
0:00:06 1614k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:56 --:--:--     0From =
https://android.googlesource.com/platform/external/svox=0A=
 * [new branch]      donut-release -> aosp/donut-release=0A=
 * [new branch]      donut-release2 -> aosp/donut-release2=0A=
 * [new branch]      eclair-passion-release -> =
aosp/eclair-passion-release=0A=
 * [new branch]      eclair-release -> aosp/eclair-release=0A=
 * [new branch]      eclair-sholes-release -> aosp/eclair-sholes-release=0A=
 * [new branch]      eclair-sholes-release2 -> =
aosp/eclair-sholes-release2=0A=
 * [new branch]      froyo      -> aosp/froyo=0A=
 * [new branch]      froyo-release -> aosp/froyo-release=0A=
 * [new branch]      gingerbread -> aosp/gingerbread=0A=
 * [new branch]      gingerbread-mr4-release -> =
aosp/gingerbread-mr4-release=0A=
 * [new branch]      gingerbread-release -> aosp/gingerbread-release=0A=
 * [new branch]      ics-factoryrom-2-release -> =
aosp/ics-factoryrom-2-release=0A=
 * [new branch]      ics-mr0    -> aosp/ics-mr0=0A=
 * [new branch]      ics-mr0-release -> aosp/ics-mr0-release=0A=
 * [new branch]      ics-mr1    -> aosp/ics-mr1=0A=
 * [new branch]      ics-mr1-release -> aosp/ics-mr1-release=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
   843824a..ad0a55b  master     -> aosp/master=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
=0D 96  167M   96  161M    0     0  1543k      0  0:01:50  0:01:46  =
0:00:04 1613k=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:01:57 --:--:--     0=0D 97  167M   97  162M    0     0  1545k      0  =
0:01:50  0:01:47  0:00:03 1651k=0D  0     0    0     0    0     0      0 =
     0 --:--:--  0:01:58 --:--:--     0=0D 98  167M   98  164M    0     =
0  1547k      0  0:01:50  0:01:48  0:00:02 1673k=0D  0     0    0     0  =
  0     0      0      0 --:--:--  0:01:59 --:--:--     0=0D 99  167M   =
99  166M    0     0  1550k      0  0:01:50  0:01:49  0:00:01 1763k=0D  0 =
    0    0     0    0     0      0      0 --:--:--  0:02:00 --:--:--     =
0=0D100  167M  100  167M    0     0  1550k      0  0:01:50  0:01:50 =
--:--:-- 1750k=0A=
=0D  0     0    0     0    0     0      0      0 --:--:--  0:02:01 =
--:--:--     0=0D  0     0    0     0    0     0      0      0 --:--:--  =
0:02:02 --:--:--     0=0D  0     0    0     0    0     0      0      0 =
--:--:--  0:02:03 --:--:--     0=0D  0     0    0     0    0     0      =
0      0 --:--:--  0:02:04 --:--:--     0=0D  2 61.8M    2 1285k    0    =
 0  10519      0  1:42:47  0:02:05  1:40:42  293k=0D 44 61.8M   44 27.5M =
   0     0   223k      0  0:04:42  0:02:06  0:02:36 6462k=0D 90 61.8M   =
90 56.2M    0     0   452k      0  0:02:19  0:02:07  0:00:12 12.8MFrom =
/home/vikram.p/android/.repo/projects/cts.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-sdk-support_r11 -> android-sdk-support_r11=0A=
 * [new tag]         android-sdk-adt_r20 -> android-sdk-adt_r20=0A=
 * [new tag]         android-sdk-adt_r16.0.1 -> android-sdk-adt_r16.0.1=0A=
 * [new tag]         android-sdk-4.0.3_r1 -> android-sdk-4.0.3_r1=0A=
 * [new tag]         android-sdk-4.0.3-tools_r1 -> =
android-sdk-4.0.3-tools_r1=0A=
 * [new tag]         android-cts-verifier-4.0_r1 -> =
android-cts-verifier-4.0_r1=0A=
 * [new tag]         android-cts-verifier-4.0.3_r1 -> =
android-cts-verifier-4.0.3_r1=0A=
 * [new tag]         android-cts-4.2_r4 -> android-cts-4.2_r4=0A=
 * [new tag]         android-cts-4.2_r3 -> android-cts-4.2_r3=0A=
 * [new tag]         android-cts-4.2_r2 -> android-cts-4.2_r2=0A=
 * [new tag]         android-cts-4.2_r1 -> android-cts-4.2_r1=0A=
 * [new tag]         android-cts-4.1_r3 -> android-cts-4.1_r3=0A=
 * [new tag]         android-cts-4.1_r2 -> android-cts-4.1_r2=0A=
 * [new tag]         android-cts-4.1_r1 -> android-cts-4.1_r1=0A=
 * [new tag]         android-cts-4.0_r1 -> android-cts-4.0_r1=0A=
 * [new tag]         android-cts-4.0.3_r3 -> android-cts-4.0.3_r3=0A=
 * [new tag]         android-cts-4.0.3_r2 -> android-cts-4.0.3_r2=0A=
 * [new tag]         android-cts-4.0.3_r1 -> android-cts-4.0.3_r1=0A=
 * [new tag]         android-cts-2.3_r13 -> android-cts-2.3_r13=0A=
 * [new tag]         android-cts-2.3_r12 -> android-cts-2.3_r12=0A=
 * [new tag]         android-cts-2.3_r11 -> android-cts-2.3_r11=0A=
 * [new tag]         android-cts-2.3_r10 -> android-cts-2.3_r10=0A=
 * [new tag]         android-cts-2.2_r8 -> android-cts-2.2_r8=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
 * [new tag]         android-4.2_r1 -> android-4.2_r1=0A=
 * [new tag]         android-4.2.2_r1.2 -> android-4.2.2_r1.2=0A=
 * [new tag]         android-4.2.2_r1.1 -> android-4.2.2_r1.1=0A=
 * [new tag]         android-4.2.2_r1 -> android-4.2.2_r1=0A=
 * [new tag]         android-4.2.1_r1.2 -> android-4.2.1_r1.2=0A=
 * [new tag]         android-4.2.1_r1.1 -> android-4.2.1_r1.1=0A=
 * [new tag]         android-4.2.1_r1 -> android-4.2.1_r1=0A=
 * [new tag]         android-4.1.2_r2.1 -> android-4.1.2_r2.1=0A=
 * [new tag]         android-4.1.2_r2 -> android-4.1.2_r2=0A=
 * [new tag]         android-4.1.2_r1 -> android-4.1.2_r1=0A=
 * [new tag]         android-4.1.1_r6.1 -> android-4.1.1_r6.1=0A=
 * [new tag]         android-4.1.1_r6 -> android-4.1.1_r6=0A=
 * [new tag]         android-4.1.1_r5 -> android-4.1.1_r5=0A=
 * [new tag]         android-4.1.1_r4 -> android-4.1.1_r4=0A=
 * [new tag]         android-4.1.1_r3 -> android-4.1.1_r3=0A=
 * [new tag]         android-4.1.1_r2 -> android-4.1.1_r2=0A=
 * [new tag]         android-4.1.1_r1.1 -> android-4.1.1_r1.1=0A=
 * [new tag]         android-4.1.1_r1 -> android-4.1.1_r1=0A=
 * [new tag]         android-4.0.4_r2.1 -> android-4.0.4_r2.1=0A=
 * [new tag]         android-4.0.4_r2 -> android-4.0.4_r2=0A=
 * [new tag]         android-4.0.4_r1.2 -> android-4.0.4_r1.2=0A=
 * [new tag]         android-4.0.4_r1.1 -> android-4.0.4_r1.1=0A=
 * [new tag]         android-4.0.4_r1 -> android-4.0.4_r1=0A=
 * [new tag]         android-4.0.3_r1.1 -> android-4.0.3_r1.1=0A=
 * [new tag]         android-4.0.3_r1 -> android-4.0.3_r1=0A=
 * [new tag]         android-4.0.2_r1 -> android-4.0.2_r1=0A=
 * [new tag]         android-4.0.1_r1.2 -> android-4.0.1_r1.2=0A=
 * [new tag]         android-4.0.1_r1.1 -> android-4.0.1_r1.1=0A=
 * [new tag]         android-4.0.1_r1 -> android-4.0.1_r1=0A=
 * [new tag]         android-2.3_r1 -> android-2.3_r1=0A=
 * [new tag]         android-2.3.7_r1 -> android-2.3.7_r1=0A=
 * [new tag]         android-2.3.6_r1 -> android-2.3.6_r1=0A=
 * [new tag]         android-2.3.6_r0.9 -> android-2.3.6_r0.9=0A=
 * [new tag]         android-2.3.5_r1 -> android-2.3.5_r1=0A=
 * [new tag]         android-2.3.4_r1 -> android-2.3.4_r1=0A=
 * [new tag]         android-2.3.4_r0.9 -> android-2.3.4_r0.9=0A=
 * [new tag]         android-2.3.3_r1.1 -> android-2.3.3_r1.1=0A=
 * [new tag]         android-2.3.3_r1 -> android-2.3.3_r1=0A=
 * [new tag]         android-2.3.2_r1 -> android-2.3.2_r1=0A=
 * [new tag]         android-2.3.1_r1 -> android-2.3.1_r1=0A=
 * [new tag]         android-2.2_r1.3 -> android-2.2_r1.3=0A=
 * [new tag]         android-2.2_r1.2 -> android-2.2_r1.2=0A=
 * [new tag]         android-2.2_r1.1 -> android-2.2_r1.1=0A=
 * [new tag]         android-2.2_r1 -> android-2.2_r1=0A=
 * [new tag]         android-2.2.3_r2.1 -> android-2.2.3_r2.1=0A=
 * [new tag]         android-2.2.3_r2 -> android-2.2.3_r2=0A=
 * [new tag]         android-2.2.3_r1 -> android-2.2.3_r1=0A=
 * [new tag]         android-2.2.2_r1 -> android-2.2.2_r1=0A=
 * [new tag]         android-2.2.1_r2 -> android-2.2.1_r2=0A=
 * [new tag]         android-2.2.1_r1 -> android-2.2.1_r1=0A=
 * [new tag]         android-2.1_r2.1s -> android-2.1_r2.1s=0A=
 * [new tag]         android-2.1_r2.1p2 -> android-2.1_r2.1p2=0A=
 * [new tag]         android-2.1_r2.1p -> android-2.1_r2.1p=0A=
 * [new tag]         android-2.1_r2 -> android-2.1_r2=0A=
 * [new tag]         android-2.1_r1 -> android-2.1_r1=0A=
 * [new tag]         android-2.0_r1 -> android-2.0_r1=0A=
 * [new tag]         android-2.0.1_r1 -> android-2.0.1_r1=0A=
=0D100 61.8M  100 61.8M    0     0   497k      0  0:02:07  0:02:07 =
--:--:-- 17.2M=0A=
>From =
/home/vikram.p/android/.repo/projects/prebuilts/gcc/linux-x86/x86/i686-li=
nux-android-4.7.git/clone.bundle=0A=
 * [new branch]      master     -> aosp/master=0A=
 * [new branch]      kitkat-release -> aosp/kitkat-release=0A=
 * [new tag]         android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r0.9 -> android-4.4_r0.9=0A=
 * [new tag]         android-4.4_r0.8 -> android-4.4_r0.8=0A=
 * [new tag]         android-4.4_r0.7 -> android-4.4_r0.7=0A=
 * [new tag]         android-4.3_r3.1 -> android-4.3_r3.1=0A=
 * [new tag]         android-4.3_r3 -> android-4.3_r3=0A=
 * [new tag]         android-4.3_r2.3 -> android-4.3_r2.3=0A=
 * [new tag]         android-4.3_r2.2 -> android-4.3_r2.2=0A=
 * [new tag]         android-4.3_r2.1 -> android-4.3_r2.1=0A=
 * [new tag]         android-4.3_r2 -> android-4.3_r2=0A=
 * [new tag]         android-4.3_r1.1 -> android-4.3_r1.1=0A=
 * [new tag]         android-4.3_r1 -> android-4.3_r1=0A=
 * [new tag]         android-4.3_r0.9.1 -> android-4.3_r0.9.1=0A=
 * [new tag]         android-4.3_r0.9 -> android-4.3_r0.9=0A=
 * [new tag]         android-4.3.1_r1 -> android-4.3.1_r1=0A=
>From =
https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/x86/i68=
6-linux-android-4.7=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
>From https://android.googlesource.com/platform/cts=0A=
 * [new branch]      eclair-passion-release -> =
aosp/eclair-passion-release=0A=
 * [new branch]      eclair-release -> aosp/eclair-release=0A=
 * [new branch]      eclair-sholes-release -> aosp/eclair-sholes-release=0A=
 * [new branch]      eclair-sholes-release2 -> =
aosp/eclair-sholes-release2=0A=
 * [new branch]      froyo      -> aosp/froyo=0A=
 * [new branch]      froyo-release -> aosp/froyo-release=0A=
 * [new branch]      gingerbread -> aosp/gingerbread=0A=
 * [new branch]      gingerbread-mr4-release -> =
aosp/gingerbread-mr4-release=0A=
 * [new branch]      gingerbread-release -> aosp/gingerbread-release=0A=
 * [new branch]      ics-factoryrom-2-release -> =
aosp/ics-factoryrom-2-release=0A=
 * [new branch]      ics-mr0    -> aosp/ics-mr0=0A=
 * [new branch]      ics-mr0-release -> aosp/ics-mr0-release=0A=
 * [new branch]      ics-mr1    -> aosp/ics-mr1=0A=
 * [new branch]      ics-mr1-release -> aosp/ics-mr1-release=0A=
 * [new branch]      ics-plus-aosp -> aosp/ics-plus-aosp=0A=
 * [new branch]      idea133    -> aosp/idea133=0A=
 * [new branch]      idea133-weekly-release -> =
aosp/idea133-weekly-release=0A=
 * [new branch]      jb-dev     -> aosp/jb-dev=0A=
 * [new branch]      jb-mr0-release -> aosp/jb-mr0-release=0A=
 * [new branch]      jb-mr1-dev -> aosp/jb-mr1-dev=0A=
 * [new branch]      jb-mr1-dev-plus-aosp -> aosp/jb-mr1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1-release -> aosp/jb-mr1-release=0A=
 * [new branch]      jb-mr1.1-dev -> aosp/jb-mr1.1-dev=0A=
 * [new branch]      jb-mr1.1-dev-plus-aosp -> =
aosp/jb-mr1.1-dev-plus-aosp=0A=
 * [new branch]      jb-mr1.1-release -> aosp/jb-mr1.1-release=0A=
 * [new branch]      jb-mr2-dev -> aosp/jb-mr2-dev=0A=
 * [new branch]      jb-mr2-release -> aosp/jb-mr2-release=0A=
 * [new branch]      jb-mr2.0-cts-release -> aosp/jb-mr2.0-cts-release=0A=
 * [new branch]      jb-mr2.0-release -> aosp/jb-mr2.0-release=0A=
 * [new branch]      jb-mr2.0.0-release -> aosp/jb-mr2.0.0-release=0A=
 * [new branch]      jb-release -> aosp/jb-release=0A=
 * [new branch]      kitkat-cts-dev -> aosp/kitkat-cts-dev=0A=
 * [new branch]      kitkat-dev -> aosp/kitkat-dev=0A=
 * [new branch]      kitkat-mr1-release -> aosp/kitkat-mr1-release=0A=
 * [new branch]      kitkat-mr1.1-release -> aosp/kitkat-mr1.1-release=0A=
 * [new branch]      kitkat-mr2-release -> aosp/kitkat-mr2-release=0A=
   83569db..d49a8af  kitkat-release -> aosp/kitkat-release=0A=
   fa58856..8d71331  master     -> aosp/master=0A=
 * [new branch]      tools_r20  -> aosp/tools_r20=0A=
 * [new branch]      tools_r21  -> aosp/tools_r21=0A=
 * [new branch]      tools_r22  -> aosp/tools_r22=0A=
 * [new branch]      tools_r22.2 -> aosp/tools_r22.2=0A=
 * [new tag]         android-4.4.1_r1 -> android-4.4.1_r1=0A=
 * [new tag]         android-4.4.2_r1 -> android-4.4.2_r1=0A=
 * [new tag]         android-4.4.2_r2 -> android-4.4.2_r2=0A=
 * [new tag]         android-4.4.3_r1 -> android-4.4.3_r1=0A=
 * [new tag]         android-4.4.3_r1.1 -> android-4.4.3_r1.1=0A=
 - [tag update]      android-4.4_r0.7 -> android-4.4_r0.7=0A=
 - [tag update]      android-4.4_r0.8 -> android-4.4_r0.8=0A=
 - [tag update]      android-4.4_r0.9 -> android-4.4_r0.9=0A=
 - [tag update]      android-4.4_r1 -> android-4.4_r1=0A=
 * [new tag]         android-4.4_r1.1 -> android-4.4_r1.1=0A=
 * [new tag]         android-4.4_r1.2 -> android-4.4_r1.2=0A=
 * [new tag]         android-cts-4.1_r4 -> android-cts-4.1_r4=0A=
 * [new tag]         android-cts-4.4_r1 -> android-cts-4.4_r1=0A=
 * [new tag]         android-sdk-4.4.2_r1 -> android-sdk-4.4.2_r1=0A=
=0A=
error: Exited sync due to fetch errors=0A=

------=_NextPart_000_015C_01CF8AF0.ABF184F0--

