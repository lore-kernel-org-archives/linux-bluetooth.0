Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Apr 2010 09:03:33 +0100 (BST)
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Regarding HS re-connection
In-Reply-To: <h2k912bb79a1004112146wd46cc9d6j36a0807563ed4d5d@mail.gmail.com>
References: <h2k912bb79a1004112146wd46cc9d6j36a0807563ed4d5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1271059413.486818.580.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 12 Apr 2010, nirav rabara wrote:

> I am bit confused regarding logic behind HS reconnection with dongle.
> 1) I paired and connect with HS with Dongle.
> 2) Now I paired and connect this HS with few other Devices, so HS
> memory will be overwritten and won't be having any information of
> Dongle paired earlier.
>
> In such situation am I need to do repairing OR forcefully I can send
> the pairing information to HS.

** please don't do top-posting **

I think your question stems from misunderstandings about pairing.
Obviously, you can't force the HS to be paired with a device that it
doesn't know about. You probably can't even connect to it unless you are
paired with it..  Bluetooth is a cable-replacement technology and pairing
is about setting up a trusted connection that does not need to be approved
every time it needs to be made. If you can forcefully pair with a device,
then any Joe with a radio could do it too from hundreds of meters away and
there would be no security in that. That you the owner of each device must
participate in the pairing process is intentional.

regards,
iain


