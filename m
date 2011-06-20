Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jun 2011 13:03:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix unpair device when disconnected for No Bonding
Message-ID: <20110620100339.GA9457@dell.ger.corp.intel.com>
References: <1308561837-11530-1-git-send-email-dmitriy.paliy@nokia.com>
 <20110620093143.GA8079@dell.ger.corp.intel.com>
 <BANLkTikE5bLgRWViQd2ynUNHS8HSRbL51A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTikE5bLgRWViQd2ynUNHS8HSRbL51A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jun 20, 2011, Dmitriy Paliy wrote:
> On Mon, Jun 20, 2011 at 12:31 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Coding-style wise your read_link_key call should be checking for < 0 or
> > specifically for -ENOENT (you're calling the function as if it returned
> > a boolean value). However, I'm thinking we might just store the
> > no-bonding info in the device struct itself so you don't need to consult
> > the storage in this case. I.e. in addition to device_is_paired there'd
> > also be a device_is_bonded function which'd make the logic like:
> >
> >        if (device_is_paired(device) && !device_is_bonded(device))
> >                device_set_paired(device, FALSE);
> >
> > Thoughts? Have you checked that this works both with hciops and mgmtops?
> 
> New ..is_bonded sounds a bit redundant since it is quite
> straightforward to check it from storage, but also ok.

It's still a file-system access for something that we could easily have
available as a flag in runtime memory. Even if you did do the
file-system read it'd make the code more readable if you had this
wrapped into a device_is_bonded function.

> I didnt touch mgmtops at all. Could you provide more inputs about what
> exactly the issue is?

I didn't say that there is an issue. I just asked if you've checked that
this works with mgmtops since the signaling between the kernel,
adapter_ops and the core bluetooth daemon is quite different wrt pairing
in that case.

Johan
