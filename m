Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Disabling passive scanning for LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE1tnCzFzg9U_B+=fDubL0i6_rTi7BsHiE2rpE6MR2ngvur-cQ@mail.gmail.com>
Date: Tue, 24 May 2016 09:43:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9E73AB7B-C5FB-42D5-ABD0-5B501E82AB8C@holtmann.org>
References: <CAE1tnCy4qcTmwxj_rnpxC3yFFgU2bOPA94WJeuvatNjWU-wu8A@mail.gmail.com> <B79CAA63-93A0-4BD6-88A8-1287B377296D@holtmann.org> <CAE1tnCzFzg9U_B+=fDubL0i6_rTi7BsHiE2rpE6MR2ngvur-cQ@mail.gmail.com>
To: mike mike <majormail999@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> I was not aware of the HCI User Channel.  It looks like it may be the
> way I have to eventually go.  The code currently uses L2CAP sockets
> for BLE GATT data and it looks like this would mean I need to write my
> own replacement.  I have not looked into writing and L2CAP socket
> replacement, but assume this will be a major task.  Any other
> suggestions or recommendations on where to start for the L2CAP socket
> replacement?

I think there are some examples in the code. However LE L2CAP (especially for GATT) is dead simple. It used a fixed channel and the only thing you need to deal with is the basic fragmentation.

Regards

Marcel

