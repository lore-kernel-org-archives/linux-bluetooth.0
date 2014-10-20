Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] doc: Add commands for Start Service Discovery and Stop Service Discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8zAKR_iGcqyeRotDoshhAp=5U8SCcKJrr+GUsAsy-4TLQ@mail.gmail.com>
Date: Mon, 20 Oct 2014 20:06:27 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B3953F7E-C8F3-45A2-A0E5-A24848E299DF@holtmann.org>
References: <1412938157-70760-1-git-send-email-marcel@holtmann.org> <CAD0=r8zAKR_iGcqyeRotDoshhAp=5U8SCcKJrr+GUsAsy-4TLQ@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> I think that RSSI_Threshold should be per UUID:
> 
> +       Command Parameters:     Address_Type (1 Octet)
> +                               Num_Filters (1 Octet)
> +                               Filter1 {
> +                                   RSSI_Threshold (1 Octet)
> +                                   UUID[i] (16 Octets)
> +                               }
> +                               Filter2 {}
> +                               ...

I need a bit more reason for this. Stating it does not convince me ;)

My take is that it is not needed for this one-shot discovering. Just select some good enough RSSI threshold and filter the rest later when you get TX power information. Like with Start Discovery it will stop once it is done with the search. So next time around you can select a different RSSI threshold.

Regards

Marcel

