Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <OF4C4942A2.E6B3B8B6-ON86257FDF.00498A15-86257FDF.004991D8@continental-corporation.com>
References: <CD551047A838BB45A959E537E0B25AB56D70B330@AZ-US1EXMB04.global.avaya.com>
 <CABBYNZ+4kLiYq+r0xg2sd8MVdTXH0z19AO4tr4F5-h1t8=QPcw@mail.gmail.com> <OF4C4942A2.E6B3B8B6-ON86257FDF.00498A15-86257FDF.004991D8@continental-corporation.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jun 2016 17:14:03 +0300
Message-ID: <CABBYNZ+7ZYR1CP8U50BwVT-y4Kp-8728ZSPbQvagJLP5WHKj+Q@mail.gmail.com>
Subject: Re: Bluez 5.37 SIG QDID?
To: burch.seymour@continental-corporation.com
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Burch,

On Mon, Jun 27, 2016 at 4:23 PM,
<burch.seymour@continental-corporation.com> wrote:
> According to the page link below, BlueZ supports SPP ver 1.1
>
> SPP                                              1.1  Server, Client
>
> This version is deprecated as of August 2013 with 1.2 replacing it.
>
> The ICS file in the 5.39 source indicates 1.2.
>
>                 Profile Version
> -------------------------------------------------------------------------------
> Item            Selected        Description
> -------------------------------------------------------------------------------
> TSPC_SPP_0_1    False           SPP v1.1 (C.1)
> TSPC_SPP_0_2    True (*)                SPP v1.2 (C.1)
> -------------------------------------------------------------------------------
> C.1: Mandatory to support only one Profile version.
> -------------------------------------------------------------------------------
>
> So, is the ICS correct, with the documentation lagging a bit?

Looks like it:

https://www.bluetooth.org/tpg/showPICS.cfm?3A000A5A005C5347545E5D14403B0C0D0E2405022413010E57503F202A5A72

It is actually correct in the SDP record so I just fixed it so it
should now show the correct version.

> -Burch
>
>
>
> From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> To:     "Tupe, Amol (Amol)" <tupea@avaya.com>,
> Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>
> Date:   06/27/2016 06:41 AM
> Subject:        Re: Bluez 5.37 SIG QDID?
> Sent by:        linux-bluetooth-owner@vger.kernel.org
>
>
>
> Hi Amol,
>
> On Fri, Jun 24, 2016 at 6:55 PM, Tupe, Amol (Amol) <tupea@avaya.com>
> wrote:
>> Hello All,
>> Is Bluez 5.37  Protocol stack has updated listing (component tested) on
> Bluetooth SIG?
>> What is QDID for 5.37?
>> I want to see which Bluetooth Specification does this stack support....
>
> We track profiles version in here:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/supported-features.txt
>
>
> There is no official QDID to each release, but you can see the public
> qualification listing here:
>
> http://www.bluez.org/qualification/
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
