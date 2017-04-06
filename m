Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC V1 00/16] hci_ldisc hci_uart_tty_close() fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ca51d648-55b9-fca8-d4b4-f19aa637197f@mentor.com>
Date: Thu, 6 Apr 2017 09:23:44 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <0D00FB91-A9A7-4307-B0BA-1B49BD1114A2@holtmann.org>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
 <AA3DD0DD-5CAC-4ADD-9B0C-4E652C93E4D6@holtmann.org>
 <ee49f939-1094-0ae0-0fa7-6c5cad112527@mentor.com>
 <119BB9FC-C735-405B-9A77-E9F102393B7D@holtmann.org>
 <3662704c-dfd4-67db-a2f9-45c949c45c6c@mentor.com>
 <ca51d648-55b9-fca8-d4b4-f19aa637197f@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

>>> If this is an issue in 4.10, then lets get this fixed / hardened.
>>> 
>> 
>> If I manage to produce some more useful results then I will post them.
>> 
> 
> I have now managed to crash the h4 Data Link protocol layer via hci_uart_tty_close().
> 
> This confirms that there is a design flaw in hci_uart_tty_close() which is independent of the Bluetooth Data Link protocol layers.
> 
> I don't have a Bluetooth Radio Module that uses h4 protocol so I used my BCSP enabled Bluetooth Radio Module that has a USB to serial interface. I realise that this is a weird setup but it is OK for this testcase because we need the h4 protocol to be timing out for transmissions. Also the BCSP Bluetooth Radio Module may send BCSP frames which will exercise the h4 receive path although rejection of the frames should occur which is as expected.

can you send me a patch set with my minor comments addressed. Then I have another look at it.

Regards

Marcel

