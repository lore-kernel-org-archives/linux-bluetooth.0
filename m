Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Jun 2018 17:27:43 +0300
Message-ID: <CABBYNZJLQ3iX4zaob6Q43zUjfwa8a26O6BJTBcpavR05BgYjfA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 00/11] Extended Adv, Scan, Connection and PHY support
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jun 14, 2018 at 3:21 PM, Jaganath Kanakkassery
<jaganath.k.os@gmail.com> wrote:
> This patch set adds new mgmt APIs for Get / Set PHY contiguration,
> Set PHY in Advertising, added mgmt-tester for the new commands,
> and also added btmgmt and monitor changes for the new commands
> and events
>
> v2: Made emulator changes onto a seperate patch
> v3: Applied Luiz's comments and fixed whitespace error
>
> Jaganath Kanakkassery (11):
>   doc/mgmt-api: Add support for Set Phy Configuration command
>   doc/mgmt-api: Add advertising phys support to flags
>   monitor: Add support PHY management commands and event
>   btmgmt: Add PHY configuration get/set commands
>   monitor: Add support for Secondary PHY flags in Add Advertising
>   btmgmt: Add support for setting PHY in add-adv
>   emulator: Add 5.0 feature support
>   mgmt-tester: Add extended advertising test cases
>   mgmt-tester: Add PHY Configuration test cases
>   mgmt-tester: Add tests for extended scanning and device found
>   mgmt-tester: Add support ext create connection and enh conn complete
>
>  doc/mgmt-api.txt    |  106 +++
>  emulator/btdev.c    |  448 +++++++++-
>  emulator/btdev.h    |    1 +
>  emulator/bthost.c   |   99 +++
>  emulator/bthost.h   |    7 +
>  emulator/hciemu.c   |    3 +
>  emulator/hciemu.h   |    1 +
>  lib/mgmt.h          |   36 +
>  monitor/bt.h        |    1 +
>  monitor/packet.c    |   68 ++
>  tools/btmgmt.c      |  145 +++-
>  tools/mgmt-tester.c | 2253 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  12 files changed, 3063 insertions(+), 105 deletions(-)
>  mode change 100644 => 100755 tools/btmgmt.c
>
> --
> 2.7.4

Patches 1-7 have been applied, thanks.

-- 
Luiz Augusto von Dentz
