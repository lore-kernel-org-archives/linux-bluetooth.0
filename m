Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU436-SMTP201A57BDC3B1920726D87E59EA10@phx.gbl>
Date: Mon, 22 Jun 2015 23:01:21 +0800
From: Xi Ruoyao <xry111@outlook.com>
MIME-Version: 1.0
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Marcel Holtmann <marcel@holtmann.org>
CC: xry111@outlook.com, "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek devices into module device
 table
References: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl> <C825257E-3CD1-4037-BC23-12D48F680EF9@holtmann.org> <55860F8C.4050205@lwfinger.net> <B0BB2A08-47CF-405D-9ACE-528550DF8337@holtmann.org> <55881A78.7060203@lwfinger.net>
In-Reply-To: <55881A78.7060203@lwfinger.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/22/2015 10:23 PM, Larry Finger wrote
> I hope that Xi's posting of the /sys file will help. Unfortunately, I 
> do not have ready access to one of these devices, but I'm making 
> arrangements to gain ssh access tomorrow so that I can test any 
> suggested patches.
Beside my earlier patch, I'll send a patch which would modify the 
generic USB BT device
entry in the device table to resolve this. You can choose one of the two 
patches since
they both make the BT works at least on my tablet.

If there are other alternate patches, I can help to test them.

-- 
Xi Ruoyao
School of Aerospace Science and Technology
Xidian University, Xi'an, China
