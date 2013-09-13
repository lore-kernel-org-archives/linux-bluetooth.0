Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Sep 2013 13:58:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluez] bnep: don't error() if kernel lacks bnep module
Message-ID: <20130913105816.GA15267@x220.p-661hnu-f1>
References: <1378477387-13186-1-git-send-email-dh.herrmann@gmail.com>
 <20130913100142.GB10346@x220.p-661hnu-f1>
 <CANq1E4QwzGfc0FMN19fLDpEz3GuJ7GeW60aKudWCtPpj-kxcUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANq1E4QwzGfc0FMN19fLDpEz3GuJ7GeW60aKudWCtPpj-kxcUA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Sep 13, 2013, David Herrmann wrote:
> On Fri, Sep 13, 2013 at 12:01 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi David,
> >
> > On Fri, Sep 06, 2013, David Herrmann wrote:
> >> If a user disables bnep kernel support, they normally do that on purpose.
> >> It's misleading to print an error during module-startup in this situation.
> >> Therefore, only print a hint that bnep-support is missing if
> >> EPROTONOSUPPORT is returned by the kernel.
> >>
> >> Furthermore, allow modules to forward ENOSYS as error to bluetoothd core
> >> to handle it as "module is not compatible with system setup" instead of an
> >> error. ENOSYS is commonly used to signal "missing kernel infrastructure"
> >> so it seems appropriate here.
> >> ---
> >>  profiles/network/common.c  |  7 ++++++-
> >>  profiles/network/manager.c | 17 ++++++++++++++---
> >>  src/plugin.c               | 11 +++++++++--
> >>  3 files changed, 29 insertions(+), 6 deletions(-)
> >
> > First of all, sorry for the delay with reviewing this. I forgot about it
> > and only bumped into it now when checking what I'd missed from the last
> > month in my linux-bluetooth folder.
> >
> >> diff --git a/profiles/network/common.c b/profiles/network/common.c
> >> index e069892..17bff30 100644
> >> --- a/profiles/network/common.c
> >> +++ b/profiles/network/common.c
> >> @@ -110,8 +110,13 @@ int bnep_init(void)
> >>
> >>       if (ctl < 0) {
> >>               int err = -errno;
> >> -             error("Failed to open control socket: %s (%d)",
> >> +
> >> +             if (err == -EPROTONOSUPPORT)
> >> +                     info("kernel lacks bnep-protocol support");
> >
> > I think warn() might be more appropriate here.
> 
> Using warn() defeats the whole purpose of this patch. I want to run
> bluetoothd without getting a warning or error, and obviously, there is
> nothing to warn _me_ about. I'm ok if you want err() or warn() here so
> other users get warned, but in that case we should just drop the
> patch.

I thought the main idea was to have a clearer log message when the
module is not there. None of the warn/error/info messages can be
suppressed (unlike DBG which is off by default). To me warn() seems more
appropriate than info() since it's meaning is "this is something that
may or may not be of concern to the user".

> So it's up to you to decide. If info() is ok, I will fix the issues
> you mentioned below, otherwise just drop it.

I do think the patch has value even though info() is not used by having
an understandable log message for what's going on.

Johan
