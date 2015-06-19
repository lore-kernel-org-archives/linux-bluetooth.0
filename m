Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Bluez-Android: L2CAP Socket Communication over
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKafyqoTVzbVv1Wk21wRSjxyH68bL+gCT_0qF9fvmUWnqkgEeg@mail.gmail.com>
Date: Fri, 19 Jun 2015 02:49:58 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CDAF57F8-C541-42AF-8FEE-47A5221DF63A@holtmann.org>
References: <CAKafyqoTVzbVv1Wk21wRSjxyH68bL+gCT_0qF9fvmUWnqkgEeg@mail.gmail.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

>  Currently, I see only rfcomm sockets, I want L2CAP socket
> communication for my use case.
> 
> I am looking to add this support.  Share me your views on this.

should be pretty straight forward to add to BfA. However getting support into Bluetooth Service into AOSP might be a bit more trickier. Native application of course can always open the L2CAP socket directly.

Regards

Marcel

