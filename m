Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Mar 2014 15:15:18 +0800
From: Adam Lee <adam8157@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
Message-ID: <20140303071518.GA3825@adam-laptop>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
 <04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org>
 <20140228073113.GA3771@adam-laptop>
 <CAJdJm_OnnyvMvLmCtYuLGOvUL0igK22gOCAP1G5KBvcJseaayw@mail.gmail.com>
 <CABBYNZLP8oPywHhMDK1D9FATFi=gMAgdfde+SjwzCp=VSGy05A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLP8oPywHhMDK1D9FATFi=gMAgdfde+SjwzCp=VSGy05A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 28, 2014 at 03:10:41PM +0100, Luiz Augusto von Dentz wrote:
> Hi Adam,
> 
> On Fri, Feb 28, 2014 at 1:22 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Adam,
> >
> > On Fri, Feb 28, 2014 at 3:31 AM, Adam Lee <adam8157@gmail.com> wrote:
> >> connect_dbus() fails sometimes with Intel 7260 bluetooth, sleeping 0.5s
> >> before executing bluetoothd workarounds it. I assume the firmware
> >> patching slows down hardware initialization then fails to connect.
> >>
> >> Any other possibility? I'm not a D-Bus guru :)
> >
> > Please provide more details, e.g. the bluetoothd logs showing the
> > problems, btmon output and which steps you are using to reproduce it.
> > If you are using bluetoothctl, tell us which commands you are using.
> 
> My guess is that either your driver is not using .setup hook to do the
> firmware patching or it is returning before it has fully initialize
> the hardware, so please also add more information what is happening on
> the driver side.

Hi, all

Please check https://bugs.launchpad.net/bugs/1221618

It's already fixed in btusb. However, if it's related to initialization
as Luiz and I guessed, maybe other hardwares have this issue too, that's
the reason I submitted that harmless retry "workaround" into BlueZ.
(have no objection to NAK)

-- 
Adam Lee
http://adam8157.info
