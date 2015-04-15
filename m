Return-Path: <cyrus@holtmann.org>
Message-ID: <552EA70F.9050706@ahsoftware.de>
Date: Wed, 15 Apr 2015 19:59:43 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de> <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org> <552C1413.1000504@ahsoftware.de> <A619270B-434E-4F83-A3A3-21E25C1DC237@holtmann.org> <552CD0F2.7080605@ahsoftware.de> <35E686A5-9C85-421D-BB8B-DF14F7D1A276@holtmann.org>
In-Reply-To: <35E686A5-9C85-421D-BB8B-DF14F7D1A276@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 14.04.2015 um 15:50 schrieb Marcel Holtmann:

> Your race power on vs keys and known devices programmed into the kernel. It needs to be done in the right order.

Hmm, I still seem to function, no sign of races, besides that I'm 
happily working without a Linux kernel.

But in regard to the patch. Maybe. No idea. It works for me (tm) and is 
faster and more reliable here than other stuff.

Regards,

Alexander Holler
