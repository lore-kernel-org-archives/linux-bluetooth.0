Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXs5wXpovbxBH6OY_VwL4-cYbaBQgrkKK95QWf1cY1bo0DZdA@mail.gmail.com>
References: <CAGXs5wXpovbxBH6OY_VwL4-cYbaBQgrkKK95QWf1cY1bo0DZdA@mail.gmail.com>
Date: Thu, 18 Oct 2012 14:29:29 +0530
Message-ID: <CAOKqjLYzVy1j+7Ka0y6UJchLCX_8n_kPVKQyKj858_xxG9PQBQ@mail.gmail.com>
Subject: Re: a short question: what are BREDR and AMP?
From: Anand Anand <anand.sinha85@gmail.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

In short :-

BREDR would stand for basic rate enhanced data rate controllers and
AMP would stand for Alternate MAC/PHY(AMP) controllers.

Kindly go through the specification document-
BLUETOOTH SPECIFICATION Version 4.0 for better understanding.

Some excerpts from the spec say :-

Core has two components :-
a)Host
b)Controllers

"An implementation of the Bluetooth Core has only one Primary Controller
which may be one of the following configurations:
• BR/EDR Controller including the Radio, Baseband, Link Manager and
optionally HCI.
• an LE Controller including the LE PHY, Link Layer and optionally HCI.
• a combined BR/EDR Controller portion and LE controller portion (as identified
in the previous two bullets) into a single Controller. This configuration
has only one Bluetooth device address shared by the combination in the
combined Controller.
A Bluetooth core system may additionally have one or more Secondary Controllers
described by the following configuration:
• an Alternate MAC/PHY (AMP) Controller including an 802.11 PAL (Protocol
Adaptation Layer), 802.11 MAC and PHY, and optionally HCI
"
quoted from Bluetooth core documentation.

Hope it helped.
Regards,
Anand

On Thu, Oct 18, 2012 at 1:56 PM, Kevin Wilson <wkevils@gmail.com> wrote:
> Hi,
> I see that the device type of hci_dev can be HCI_BREDR or HCI_AMP.
> (hci_register_dev() in net/bluetooth/hci_core.c).
>
> I have a question if I may: what are these two types?
>
> rgs,
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
