Return-Path: <cyrus@holtmann.org>
Message-ID: <559BDF20.9090905@hschmitt.de>
Date: Tue, 07 Jul 2015 16:16:00 +0200
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Why doesn't plugins/sixaxis.c set devices as Trusted?
References: <1436188651.26954.9.camel@hadess.net> <559B5633.8000102@ahsoftware.de>
In-Reply-To: <559B5633.8000102@ahsoftware.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 07.07.2015 um 06:31 schrieb Alexander Holler:
> Am 06.07.2015 um 15:17 schrieb Bastien Nocera:
>> Hey,
>>
>> I don't understand the reason why plugins/sixaxis.c doesn't set the
>> device as trusted when plugged in.
>
> It's because of security. If you trust a bluetooth device on Linux,
> you're trusting it for all services.
Just as a side note: This is not a good security rule. Why should I 
trust a game controller on any other service then controlling my game moves?


Best regrads,
Harald
