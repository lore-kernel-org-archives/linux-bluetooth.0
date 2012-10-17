Return-Path: <cyrus@holtmann.org>
Message-ID: <1350493622.26318.114.camel@aeonflux>
Subject: Re: [RFCv0 0/8] Handling physical and logical link
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 17 Oct 2012 10:07:02 -0700
In-Reply-To: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350399670-12418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Set of patches adding handling for physical and logical link
> complete events.
> 
> Andrei Emeltchenko (8):
>   Bluetooth: AMP: Process Physical Link Complete evt
>   Bluetooth: AMP: Process Logical Link complete evt
>   Bluetooth: Add logical link create function
>   Bluetooth: AMP: Process Disc Logical Link
>   Bluetooth: AMP: Process Disc Physical Link complete evt
>   Bluetooth: AMP: Remove hci_conn receiving error command status
>   Bluetooth: Disconnect logical link when deleteing chan
>   Bluetooth: Add put(hcon) when deleting hchan

I looked over the patches and the look fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


