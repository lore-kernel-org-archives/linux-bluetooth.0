Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: RFCOMM server and current Bluez
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CADU0VqyJxZo2QDOY0FgOTSFNRGCgXbPuZhL7viuAV_ucFOoPkg@mail.gmail.com>
Date: Tue, 12 Dec 2017 16:52:51 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F0362283-E06D-46D7-9A48-24A81A3BC64A@holtmann.org>
References: <CADU0VqyJxZo2QDOY0FgOTSFNRGCgXbPuZhL7viuAV_ucFOoPkg@mail.gmail.com>
To: John Klug <ski.brimson@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> Would anyone know of any public examples of using RFCOMM with current
> methods, or does RFCOMM require compatibility mode and SPD?
> 
> There does not seem to be any RFCOMM server examples included with Bluez.
> 
> Or would there be any detailed documentation on how an RFCOMM server
> would be written?

look at doc/profile-api.txt and you will find Python based test example for it. Also profiles/iap/main.c is a super simple (also incomplete) example for a custom service like Apple’s iAP.

Regards

Marcel

