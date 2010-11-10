Return-Path: <cyrus@holtmann.org>
Subject: Re: I think we should add GoepL2capPsm attribute in sdp.h
From: Marcel Holtmann <marcel@holtmann.org>
To: hui li <nami.li1984@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimThap03_iYvxYyw39HOkMRAzzkscKjGMwmY7dX@mail.gmail.com>
References: <AANLkTimThap03_iYvxYyw39HOkMRAzzkscKjGMwmY7dX@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Nov 2010 14:19:25 +0900
Message-ID: <1289366365.9615.227.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hui,

> Currently there is no GoepL2capPsm attribute value in sdp.h, I think
> we should add this to supprot GOEP v2.0.
> Maybe we can add
> #define SDP_ATTR_GOEP_L2CAP_PSM			0x0200
> in sdp.h.

please send a proper patch for this and provide a clear reference to it
since this is not part of the assigned numbers document.

Regards

Marcel


