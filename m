Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: lpeltan@insys-tec.de,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: question: auto-trust after pairing
Date: Thu, 17 May 2018 10:39:42 +0200
Message-ID: <3250330.I0D8qQTuZl@ix>
In-Reply-To: <CABBYNZLeRu5pe+4gYvbv=aGO6x+4H3Ki5xoazKJWyawYnkozig@mail.gmail.com>
References: <AM3PR06MB083875B8578B90DE59B104F69A920@AM3PR06MB0838.eurprd06.prod.outlook.com> <CABBYNZLeRu5pe+4gYvbv=aGO6x+4H3Ki5xoazKJWyawYnkozig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thursday, 17 May 2018 09:55:05 CEST Luiz Augusto von Dentz wrote:
> Hi Libor,
> 
> On Wed, May 16, 2018 at 2:01 PM Libor Peltan <lpeltan@insys-tec.de> wrote:
> > Hello everyone,
> > 
> > I'd like to ask about specific configuration of bluetooth daemon.
> > 
> > 1. How it works for me:
> > I'm running BlueZ 5.47 on an ARMv7-powered board with a Qualcomm chip.
> > When a device (mostly a phone) connects via bluetooth, it is paired
> 
> automatically without any PIN exchange.
> 
> > In order to use PAN protocol over bluetooth, the connected device needs
> 
> to be trusted.
> 
> > To achieve this, I created an external program, that communicates with
> 
> bluetoothd via DBus. When a DBus message arrives informing about new paired
> device, the program responds (if some policy conditions are fulfilled) with
> DBus message requesting trusting this device. Overall, this makes an approx
> 0.5 secs delay between pairing and trusting of the device.
> 
> > 2. My problem
> > When testing an iPhone in the role of the connecting device, after the
> 
> pairing I can see an error message on the iPhone. After trying to connect
> again, it already works. It's not nice, for the future users, to always
> receive an error message on first attempt - I need to avoid this.
> 
> > I observed that after pairing, the iPhone immediately (in 10 millis)
> 
> tries to connect to PAN. This is not yet possible, since it's not yet
> trusted. This causes the error message.
> 
> > 3. My question
> > Is there a way to change bluetoothd, so that he automatically trusts a
> 
> device when it pairs?
> 
> > Is it possible to turn this "auto-trust" mode on and off without
> 
> restarting bluetoothd?
> 
> Even in case of just works pairing there should be a request to the agent
> to accept it, trust affects connection authorization perhaps we are not
> doing it properly for PAN since there should delay a little bit the
> accepting of the L2CAP connection but that is done for all profiles so Id
> be surprised that is what is causing the problem.

My guess would that there is no agent at all, so pairing fallback to JustWorks 
but service autorization fails if there is no agent. I'd suggest to have 
simple agent that will authoriza service connection. Other option would be to 
set device trusted as soon as it gets connected (ie before pairing is 
completed).

-- 
pozdrawiam
Szymon Janc


