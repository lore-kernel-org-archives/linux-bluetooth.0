Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 5/7] soc: mediatek: add a fixed wait for SRAM stable
Date: Thu, 5 Apr 2018 16:42:58 +0000
Message-ID: <DM5PR2101MB1032103E32029A14A2E41D1FFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <0fc10b2498c6dbe20141831c722c32cc74330d3d.1522736996.git.sean.wang@mediatek.com>
In-Reply-To: <0fc10b2498c6dbe20141831c722c32cc74330d3d.1522736996.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 83.4612)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Failed to apply! Possible dependencies:
    40b3b88a117c ("soc: mediatek: reuse read[l,x]_poll_timeout helpers")

v4.14.32: Failed to apply! Possible dependencies:
    40b3b88a117c ("soc: mediatek: reuse read[l,x]_poll_timeout helpers")

v4.9.92: Failed to apply! Possible dependencies:
    40b3b88a117c ("soc: mediatek: reuse read[l,x]_poll_timeout helpers")
    52510ee93488 ("soc: mediatek: add SCPSYS power domain driver for MediaT=
ek MT7622 SoC")

v4.4.126: Failed to apply! Possible dependencies:
    40b3b88a117c ("soc: mediatek: reuse read[l,x]_poll_timeout helpers")
    52510ee93488 ("soc: mediatek: add SCPSYS power domain driver for MediaT=
ek MT7622 SoC")


Please let us know if you'd like to have this patch included in a stable tr=
ee.

--
Thanks.
Sasha=
