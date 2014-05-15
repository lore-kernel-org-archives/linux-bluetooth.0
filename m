Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 May 2014 18:33:37 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCHv2 BlueZ 0/5] plugin/sixaxis: Set leds using the sysfs
 leds class
Message-Id: <20140515183337.63e40115dfa042aa6acd0326@ao2.it>
In-Reply-To: <5374DD22.9060303@gmail.com>
References: <1399370776-5027-1-git-send-email-ao2@ao2.it>
	<1400103605-25183-1-git-send-email-ao2@ao2.it>
	<5374DD22.9060303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 15 May 2014 11:28:34 -0400
Frank Praznik <frank.praznik@gmail.com> wrote:

> The current version of get_js_numbers() won't work correctly on 
> Bluetooth gamepads if more than one is connected.  Currently it looks 
> for the correct js* device via just the PHYS attribute which works on 
> USB, but PHYS is the same value for all Bluetooth devices on a single 
> adapter (MAC of the host Bluetooth adapter).  As is, all Bluetooth DS3 
> controllers will end up with the LEDs set to the controller number of 
> the first js* device on the Bluetooth adapter.  A simple fix would be to 
> compare against PHYS and UNIQ when searching for the correct js device 
> since UNIQ contains the individual device MAC address.
>

Thanks Frank, I'll make sure I test with multiple controllers when I
get back on simplifying get_js_numbers(), if that takes too long I
will send a fix to the current version following your suggestion.

The patch 1 I sent in the first round would result in picking the
correct number in the general case but, as I said, timing becomes more
critical the first time the joydev module is inserted.

Maybe we could tell libudev to monitor js devices and then navigate to
the hidraw node, instead of the other way around like it is done now.

Ciao,
   Antonio

> On 5/14/2014 17:40, Antonio Ospite wrote:
> > Hi,
> >
> > here's the updated patch series, the commit messages have been fixed too!
> >
> > I am leaving out patch 1/5 for now:
> >
> >    plugins/sixaxis: Simplify get_js_numbers()
> >
> > I decided to do so because there is still some timing issue: the new
> > procedure to retrieve the js number is faster, and on the _very_first_
> > run it fails and returns 0, I suspect this has to do with the fact that
> > the joydev module gets loaded after the hidraw uevent and the
> > enumeration in the plugin completes before the js node shows up in
> > sysfs, I'll do some more experiments on that.
> >
> > So please apply only patches from 2 to 5, thanks, I kept the numbering
> > as in v1 for clarity.
> >
> > Changes since v1 are annotated in each patch.
> >
> > The changes have been tested with libudev-204 along with linux-3.13,
> > linux 3.14 and linux-3.15-rc4.
> >
> > To recap:
> >    - on kernels < 3.14 the hidraw mechanism is used
> >    - on kernels >= 3,14 the sysfs mechanism is used to avoid
> >      inconsistencies with rumble effects.
> >
> > Thanks,
> >     Antonio
> >
> > Antonio Ospite (4):
> >    plugins/sixaxis: Factor out a set_leds_hidraw() function
> >    plugins/sixaxis: Factor out a calc_leds_bitmap() function
> >    plugins/sixaxis: Add a get_leds_data() function
> >    plugins/sixaxis: Add a set_leds_sysfs() function
> >
> >   configure.ac      |   4 +-
> >   plugins/sixaxis.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++-------
> >   2 files changed, 158 insertions(+), 24 deletions(-)
> >
> 
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
