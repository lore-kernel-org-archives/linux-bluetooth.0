Return-Path: <cyrus@holtmann.org>
Message-ID: <1349882904.27233.129.camel@aeonflux>
Subject: Re: [PATCHv1 0/6] Handle AMP_LINK
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 17:28:24 +0200
In-Reply-To: <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1349879912-23633-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add code for handling High Speed link
> 
> Changes:
> 	* v1: Fixes according to Marcel's review
> 	* RFCv1: Initial release
> 
> Andrei Emeltchenko (6):
>   Bluetooth: Allow to set flush timeout
>   Bluetooth: AMP: Handle AMP_LINK timeout
>   Bluetooth: AMP: Add handle to hci_chan structure
>   Bluetooth: AMP: Handle number of compl blocks for AMP_LINK
>   Bluetooth: AMP: Handle AMP_LINK connection
>   Bluetooth: AMP: Hanlde AMP_LINK case in conn_put

patches look fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


