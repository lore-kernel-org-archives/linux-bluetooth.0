Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH BlueZ] doc/mgmt-api: Add BREDR PHYs in PHY Configuration
 Commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJvBg+HFzpYLRfSk1_OAX29gC=SZhTxaAaF4OZ3+_Zkjw@mail.gmail.com>
Date: Thu, 28 Jun 2018 15:43:52 +0200
Cc: Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <06A78F52-DA5E-46E4-8832-699DA28C5541@holtmann.org>
References: <1530164990-2148-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <CABBYNZJvBg+HFzpYLRfSk1_OAX29gC=SZhTxaAaF4OZ3+_Zkjw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> ---
>> doc/mgmt-api.txt | 74 ++++++++++++++++++++++++++++++--------------------------
>> 1 file changed, 40 insertions(+), 34 deletions(-)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 87982e0..3ef367d 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2948,34 +2948,49 @@ Get PHY Configuration Command
>>        Command Code:           0x0043
>>        Controller Index:       <controller id>
>>        Command Parameters:
>> -       Return Parameters:      Supported_phys (2 Octet)
>> -                               Selected_phys (2 Octet)
>> +       Return Parameters:      Supported_phys (4 Octet)
>> +                               Configurable_PHYs (4 Octets)
>> +                               Selected_phys (4 Octet)
>> +
>> +       The PHYs parameters are a bitmask with currently the
>> +       following available bits:
>> +
>> +               0       BR 1M 1-Slot
>> +               1       BR 1M 3-Slot
>> +               2       BR 1M 5-Slot
>> +               3       EDR 2M 1-Slot
>> +               4       EDR 2M 3-Slot
>> +               5       EDR 2M 5-Slot
>> +               6       EDR 3M 1-Slot
>> +               7       EDR 3M 3-Slot
>> +               8       EDR 3M 5-Slot
>> +               9       LE 1M TX
>> +               10      LE 1M RX
>> +               11      LE 2M TX
>> +               12      LE 2M RX
>> +               13      LE Coded TX
>> +               14      LE Coded RX
> 
> I wonder if there were any discussions regarding the BR/EDR PHYs?
> Usually we just let the controller auto select the best so we this we
> want to allow userspace to tell which PHYs to enable? Is there any use
> case where this actually makes sense? Well I guess the same is valid
> for LE as well so at least with bluetoothd I don't think we would be
> exposing these settings to applications so I guess it would be more of
> a test command.

in certain products you might want to select specific packet types. Especially since we had that capability via the ioctl since day one. So this is moving that to mgmt as well. With BR/EDR the choice was that the packet types were inverted so by default things have been switched on. For LE that is not the case since until enabled things will stay that way. In specific for LE Coded you need to do extra work.

The kernel exposing this configuration options is the right thing to do. Exposing them outside of bluetoothd is pretty much useless. At most they can be some main.conf options if products require to limit packet types or LE PHY choices.

One important thing is actually being able to report what the controller supports. Is it BR only, does it support EDR, what LE PHYs are supported so that this can be gathered from the kernel without injecting HCI commands ore using old ioctls.

Regards

Marcel

