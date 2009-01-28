Return-Path: <cyrus@holtmann.org>
Subject: Re: wifi coexistence
From: Marcel Holtmann <marcel@holtmann.org>
To: Paulo Bustelo Codesido <pbustelo@ontouch.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <116E93DD-490C-4D73-A821-C3E9BD720152@ontouch.es>
References: <116E93DD-490C-4D73-A821-C3E9BD720152@ontouch.es>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:55:51 +0100
Message-Id: <1233122151.18259.19.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

> Does anybody know why I have interferences between bluetooth and wifi  
> (wifi stops) while using a AFH bluetooth device with blueZ?
> 
> Has anything to do with blueZ?
> 
> the bluetooth device is a WT11-E-HCI from Bluegiga.
> 
> How can I avoid it?
> 
> I was trying to put evrything but antenna into a aluminium box... But  
> the problem is still there....
> 
> "hciconfig hci0 afhmode" returns enabled...

the AFH is limited in what it can do. It tries its best to do the right
thing. You would have to manually block the channels your WiFi is
submitting on. Check with hcitool afh.

Regards

Marcel


