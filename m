Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <55881A78.7060203@lwfinger.net>
Date: Mon, 22 Jun 2015 09:23:52 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Xi Ruoyao <xry111@outlook.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device
 table
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl> <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org> <55860F8C.4050205@lwfinger.net> <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org>
In-Reply-To: <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/22/2015 05:33 AM, Marcel Holtmann wrote:

Marcel,

> these Realtek devices are causing the most messy setup in a generic driver. And Bluetooth USB support has been really clean and simple for the last 10 years. I really wonder how many ways this gets done wrong before someone gets a clue and gets this right. At the end of the day this USB transport is 15 years old.
>
> Anyway, for obvious reasons the content of /sys/kernel/debug/usb/devices should be included here so that someone can actually look at how the USB endpoints are configured.

I cannot disagree about the messiness of the Realtek setup.

I hope that Xi's posting of the /sys file will help. Unfortunately, I do not 
have ready access to one of these devices, but I'm making arrangements to gain 
ssh access tomorrow so that I can test any suggested patches.

Larry
