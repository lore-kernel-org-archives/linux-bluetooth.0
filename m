Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Nov 2010 14:51:45 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Bluetooth Low energy support
Message-ID: <20101110125145.GH20384@null>
References: <1287406976-13463-1-git-send-email-ville.tervo@nokia.com>
 <AANLkTina_HUT3SGEUMemVLrD4N3+Ni+xCsaC57whHDZG@mail.gmail.com>
 <20101110062030.GE20384@null>
 <AANLkTi=iCXfycMzHbgwS3jbvCxJvzVh97iSDRf4WhQeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=iCXfycMzHbgwS3jbvCxJvzVh97iSDRf4WhQeQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 10, 2010 at 11:46:47AM +0100, ext Anderson Lizardo wrote:
> On Wed, Nov 10, 2010 at 2:20 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > On Tue, Nov 09, 2010 at 05:25:10PM +0100, ext Anderson Lizardo wrote:
> >> While doing tests with your most recent trees (using devel HW from
> >> TI), I'm getting consistent panic on the following test:
> >>
> >> (dev1) hciconfig hciX leadv
> >> (dev2) hcitool -i hciX lecc <dev2_addr>
> >
> > Did you have server listening on dev 2 on ATT socket?
> 
> I had no bluetoothd running on any side (not sure if that was your question).

That was actually my question :) Thanks.

-- 
VIlle
