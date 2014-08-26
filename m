Return-Path: <cyrus@holtmann.org>
Message-ID: <1409062462.7335.27.camel@pohly-mobl1.fritz.box>
Subject: Re: Suspend + abort session => obexd unusable
From: Patrick Ohly <patrick.ohly@intel.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc: Mateusz Potrola <mateusz.polrola@gmail.com>,
	Bluez <linux-bluetooth@vger.kernel.org>
Date: Tue, 26 Aug 2014 16:14:22 +0200
In-Reply-To: <CACumGOKfr8XBtYAOxoDKh6vqQnJGbq4xPCDggGRV-PEu_3LnBw@mail.gmail.com>
References: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
	 <CACumGOKfr8XBtYAOxoDKh6vqQnJGbq4xPCDggGRV-PEu_3LnBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2014-08-26 at 16:52 +0300, Von Dentz, Luiz wrote:
> Hi Patrick,
> 
> On Tue, Aug 26, 2014 at 4:39 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > Hello Luiz!
> >
> > I noticed a problem in obexd and/or Bluez 5.21 (Debian Testing):
> >
> > - PullAll from Samsung Galaxy S3
> > - Suspend
> > - kill the process who called obexd
> > - try to pull again from a different process
> > => GDBus.Error:org.bluez.obex.Error.Failed: Unable to find service
> > record
> >
> > obexd notices that its client died (there is a InterfacesRemoved signal
> > for the transfer and session path), but the cleanup seems to leave the
> > device or the local side in an unusable state.
> >
> > Killing obexd and restarting it makes it possible to access the phone
> > again.
> >
> > I've not been able to reproduce this without suspending first.
> 
> It might be related to the patch Ive just sent, there is a bug where
> Transfer.Cancel would not work in case it is suspended.

Beware that Transfer.Cancel was not involved in the steps above. The
client which might have canceled the transfer just got killed instead.
Perhaps it leads to the same code path, so this might still be the same
issue.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.



