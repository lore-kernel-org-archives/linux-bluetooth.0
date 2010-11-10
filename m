Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Nov 2010 08:20:30 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Bluetooth Low energy support
Message-ID: <20101110062030.GE20384@null>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
 <AANLkTina_HUT3SGEUMemVLrD4N3+Ni+xCsaC57whHDZG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTina_HUT3SGEUMemVLrD4N3+Ni+xCsaC57whHDZG@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 09, 2010 at 05:25:10PM +0100, ext Anderson Lizardo wrote:
> Hi Ville,
> 
> On Mon, Oct 18, 2010 at 9:02 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > Hi,
> >
> > Here is v2 of bluetooth low energy patch set.
> > Changes from previous version.
> 
> While doing tests with your most recent trees (using devel HW from
> TI), I'm getting consistent panic on the following test:
> 
> (dev1) hciconfig hciX leadv
> (dev2) hcitool -i hciX lecc <dev2_addr>

Did you have server listening on dev 2 on ATT socket?

> 
> I attached two logs. One is from dev1 machine (which has the oops),
> the other is from the dev2 machine.

I'll try to fix this today.

-- 
Ville
