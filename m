Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171127133930.GB24336@x1c.home>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com> <20171127133930.GB24336@x1c.home>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Mon, 27 Nov 2017 20:26:34 +0530
Message-ID: <CAJzH+bpHN2w2RDL5GC5fuKNbVKr7_SZzXz70ckUUQbd=K3xphA@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] doc/mgmt-api: Add support for Get PHY information command
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Hi Jaganath,
>
> On Mon, Nov 20, 2017, Jaganath Kanakkassery wrote:
>> +Get PHY Information Command
>> +==========================
>> +
>> +     Command Code:           0x0043
>> +     Controller Index:       <controller id>
>> +     Command Parameters:
>> +     Return Parameters:      Supported_phys (1 Octet)
>> +                             Selected_phys (1 Octet)
>
> Shouldn't the command have "Default" in its name, to be consistent with
> your second patch?

I did not add "Default" since the API also returns the Supported PHYs by the
controller. Will "Current_default_phys" be more intuitive than "Selected_phys"?

> If it's not the default that this is returning, then
> shouldn't there be a reference to which connection it applies to
> (assuming this is intended to map to the HCI_LE_Set_PHY command)?
>
> What about the PHY_options HCI parameter, where is that planned to be
> specified?
>

This API is not for any connection (and so not mapped to
HCI_LE_Set_PHY command).
For that we have L2CAP socket option for which i have already raised a patch
"[PATCH] Bluetooth: Define l2cap sock option for LE PHYs"
As you mentioned we would need to add support for PHY_options in that.

Thanks,
Jaganath
