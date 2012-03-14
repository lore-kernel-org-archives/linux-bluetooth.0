Return-Path: <cyrus@holtmann.org>
Message-ID: <1331747344.14217.105.camel@aeonflux>
Subject: Re: Encrypting problem while sending data via bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Mar 2012 10:49:04 -0700
In-Reply-To: <4F60B259.5040800@tu-ilmenau.de>
References: <4F60B259.5040800@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffan,

> At first: Sorry for my bad english, it's not my native language. So i 
> wrote my problem in german and english.
> 
> My problem refers to bluez. I didn't got useful hits on Google, IRC 
> didnt help and the only answer i got in a forum was: "there are not many 
> people who are familiar with that". So i hope you can help me.
> 
> My problem:
> After installing the latest bluez, i connected two gentoo-PC's (v2.1.6) 
> via two bluetooth-dongles (BT3.0).
> PC2:# rfcomm listen 0 1
> PC1:# rfcomm connect 0 <bluetooth-adress> 1
> This works fine.
> 
> But now, when i try to send some data:
> PC2:# cat /dev/rfcomm0
> PC1:# echo "test" > /dev/rfcomm0
> it looks like this on the screen of PC2:
> "^J^J^J^J^^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^test^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J" 

it has nothing to do with encryption. These are TTY terminal settings.
That is why rfcomm tool has a -r (raw TTY mode) switch. And that switch
is documented in manpage.

Regards

Marcel


