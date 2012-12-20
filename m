Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 10:04:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrey Voropaev <voropaev.andrey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Authentication Rejected when pairing stereo headset
Message-ID: <20121220080447.GA561@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrey,

On Thu, Dec 20, 2012, Andrey Voropaev wrote:
> when I try 'simple-agent hci0 XX:XX:XX' I always get error
> 
> Creating device failed: org.bluez.Error.AuthenticationRejected:
> Authentication Rejected
> 
> I'm doing everything as root, so what could be the reason for
> "Authentication Rejected"? Incompatible hardware? Wrong configuration?
> 
> In which direction should I be searching?

The bluetoothd debug logs (run with -d switch) would be interesting as
well as the HCI level trace (for which you can use e.g. hcidump).

Johan
