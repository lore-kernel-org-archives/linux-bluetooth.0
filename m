Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Elliot Saba <staticfloat@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Understanding connecting to BLE keyboard
Date: Mon, 14 Sep 2015 14:46:58 +0200
Message-ID: <10452927.a6KM84WJTg@leonov>
In-Reply-To: <CABBYNZKi=TSWQxyN6j1=a++V5p-e8viB=qWxnX1pGQShz9A-YA@mail.gmail.com>
References: <CAGGi21YVrRB06R8ahxRLBZ=xZkNKGnCsetL1xUQx9DPLeAGGXA@mail.gmail.com> <CABBYNZKi=TSWQxyN6j1=a++V5p-e8viB=qWxnX1pGQShz9A-YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 14 of September 2015 15:25:58 Luiz Augusto von Dentz wrote:
> Hi Elliot,
> 
> On Sun, Sep 13, 2015 at 8:58 AM, Elliot Saba <staticfloat@gmail.com> wrote:
> > Hello there, I recently obtained a Microsoft Designer BLE
> > keyboard/mouse, and I thought I would attempt to connect it up to my
> > Linux box for fun.  Needless to say, I've met with some problems,
> > primarily with the authentication mechanisms I believe.
> > 
> > First off, I am using bluez 5.23 on SteamOS (A debian derivative) with
> > a Broadcom BCM4352 controller.
> > 
> > When attempting to connect to the bluetooth keyboard using my OSX
> > machine, it prompts me to enter a PIN, and after doing so, things are
> > fine and dandy.  When using gnome-bluetooth to attempt to connect, it
> > thinks about it for a little bit, and then reverts to its previous
> > status ("Not Set Up") rather than prompting me for a PIN or anything
> > like that.
> > 
> > When attempting to connect via the command line using bluetoothctl,
> > (First I start a KeyboardOnly agent, then scan for the device, then
> > "trust" it, then "pair" it) bluetoothctl initially reports the
> > connection has succeeded, but then immediately disconnects and prints
> > out the error "org.bluez.Error.AuthenticationCanceled".
> 
> Try using btmon to get a trace of what is going on, from the error it
> sounds like the remote is canceling the pairing so perhaps it times
> out or something. Btw, have you checked the manual how the pairing is
> suppose to be done? Did you enter the pincode in the keyboard itself?

I think the problem is use of KeyboardOnly which in LE legacy pairing results 
in JustWorks pairing if both sides have this IO capa. If there is requirement 
for authenticated link then this will fail. I'd suggest first checking with
proper IO capa ie. KeyboardDisplay.

> > When attempting to connect via the command line using gatttool in
> > interactive mode, I run into similar issues; I can type "connect" and
> > it initially reports success, but any command I then type to query the
> > device immediately reports "Command Failed: Disconnected".
> > 
> > Is there some way I can increase the amount of debugging information
> > available to me in order to try and track down exactly what's going
> > wrong here?  I admit that my knowledge of the proper way to connect
> > this device in linux is shaky at best, and I would "Read The Manual"
> > if I knew where to look for it.  Pointers on where to go to read up on
> > this whole process are definitely welcome.
> 
> The problem seems to be at pairing which is mandatory if the device
> implements HoG profile, so I guess no command will succeed until
> pairing is done properly.

-- 
BR
Szymon Janc
