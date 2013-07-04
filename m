Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <51d54149.42a5420a.2de5.6abcSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org> <51d54149.42a5420a.2de5.6abcSMTPIN_ADDED_BROKEN@mx.google.com>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
Date: Thu, 4 Jul 2013 13:15:14 -0400
Message-ID: <CA+_d9qfyLJW34BaZLG1bHVch4jJ+UCa3AsWreAfSikPL_J3YHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/6] emulator: add LE advertising and scanning support
To: Tim Wei <junping.wei@ivtcorporation.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim.

We are using emulator to write test tools. You can find some usage at
tools/mgmt-tester.c.
That way you don't need to have real device (or features) to test some
specific code.

Regads,
Jefferson Delfes.

On Thu, Jul 4, 2013 at 5:32 AM, Tim Wei <junping.wei@ivtcorporation.com> wrote:
> Hi Jefferson,
>
> I am new to BlueZ.
> Could you please let me know what the purpose of having this module, I mean
> emulator?
>
> Thank you and Best Regards,
> Tim Wei
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Jefferson Delfes
> Sent: Thursday, July 04, 2013 4:55 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Jefferson Delfes
> Subject: [PATCH BlueZ 0/6] emulator: add LE advertising and scanning support
>
> In order to write discovery tests for LE, we need some implementation
> on emulator side.
> This patch series basically reports virtual devices in adv mode for
> devices in scan mode.
>
> This new series was reorganized by merging some commits and removing
> others not related to discovery tests. Note that this is just a first
> set, based on a RFC sent a while ago by Bruna Moreira. Future patches
> will build on these patches.
>
> Jefferson Delfes (6):
>   emulator: Store LE advertising data length in btdev
>   emulator: Implement basic LE set adv enable command
>   emulator: Store LE scan state of virtual controller
>   emulator: Disallow LE set scan params command when scan is enabled
>   emulator: Dummy LE set advertising parameters
>   emulator: Implement LE advertising report
>
>  emulator/btdev.c | 102
> +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  monitor/bt.h     |  13 +++++++
>  2 files changed, 113 insertions(+), 2 deletions(-)
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
