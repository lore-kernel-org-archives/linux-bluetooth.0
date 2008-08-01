Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808011232.36918.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
	 <200808011232.36918.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 19:43:38 +0200
Message-Id: <1217612618.7819.6.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > Also the HCI_RESET thing needs to be turn-around. We always do  
> > HCI_RESET except for some chips where it will break (old CSR ones for  
> > example).
> 
> OK, I am making a separate patch. I've looked at 2.6.26-mh. It seems
> to do the reset only for quirky devices. Is the reversal just planned or am
> I looking at the wrong trees?

the reversal is just planned, but we should do it soon since we need the
reset quirk for almost every Broadcom chip.

Regards

Marcel


