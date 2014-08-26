Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
References: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
Date: Tue, 26 Aug 2014 16:52:30 +0300
Message-ID: <CACumGOKfr8XBtYAOxoDKh6vqQnJGbq4xPCDggGRV-PEu_3LnBw@mail.gmail.com>
Subject: Re: Suspend + abort session => obexd unusable
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Mateusz Potrola <mateusz.polrola@gmail.com>,
	Bluez <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Tue, Aug 26, 2014 at 4:39 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> Hello Luiz!
>
> I noticed a problem in obexd and/or Bluez 5.21 (Debian Testing):
>
> - PullAll from Samsung Galaxy S3
> - Suspend
> - kill the process who called obexd
> - try to pull again from a different process
> => GDBus.Error:org.bluez.obex.Error.Failed: Unable to find service
> record
>
> obexd notices that its client died (there is a InterfacesRemoved signal
> for the transfer and session path), but the cleanup seems to leave the
> device or the local side in an unusable state.
>
> Killing obexd and restarting it makes it possible to access the phone
> again.
>
> I've not been able to reproduce this without suspending first.

It might be related to the patch Ive just sent, there is a bug where
Transfer.Cancel would not work in case it is suspended.
