Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 27 Nov 2017 16:21:09 +0530
Message-ID: <CAJzH+bo+=MWO6X8=+12JHMw_08rqwSDAknHbSGWvv8EJ-e3rJg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] LE New PHYs kernel interfaces
To: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Ping

> These patches enables user to get the supported phys by the
> controller and set preferred phy to be used in subsequent
> scanning and connection initiation.
>
> Also added flags to support user selection for phy to be
> advertised.
>
> v1: Applied Marcel's comments
> v2: Applied Eramoto's comments
>
> Jaganath Kanakkassery (3):
>   doc/mgmt-api: Add support for Get PHY information command
>   doc/mgmt-api: Add support for Set default Phy command
>   doc/mgmt-api: Add advertising phys support to flags
>
>  doc/mgmt-api.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>

Thanks,
Jaganath
