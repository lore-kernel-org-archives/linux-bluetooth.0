Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
References: <1409060382.7335.25.camel@pohly-mobl1.fritz.box>
From: =?UTF-8?B?TWF0ZXVzeiBQw7PFgnJvbGE=?= <mateusz.polrola@gmail.com>
Date: Wed, 27 Aug 2014 07:59:49 +0100
Message-ID: <CAA8zYt6JCTCeAOZY8mX3k8z1HoONS=peqnX8PLLgspH-rbsm5A@mail.gmail.com>
Subject: Re: Suspend + abort session => obexd unusable
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>,
	Bluez <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick, Luiz

On Tue, Aug 26, 2014 at 2:39 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> I noticed a problem in obexd and/or Bluez 5.21 (Debian Testing):
>
> - PullAll from Samsung Galaxy S3
> - Suspend
> - kill the process who called obexd
> - try to pull again from a different process
> => GDBus.Error:org.bluez.obex.Error.Failed: Unable to find service
> record

I also was able to reproduce the issue with Bluez 5.21 and Motorola
RAZRi/HTC Desire Z using steps described by Patrick.

> obexd notices that its client died (there is a InterfacesRemoved signal
> for the transfer and session path), but the cleanup seems to leave the
> device or the local side in an unusable state.

What I noticed is that after killing client process, phone still seems
to see active session - Bluetooth icon on the phone is still blue (it
turns blue when there is an active session), so that may indicate that
phone is left in unusable state.

> Killing obexd and restarting it makes it possible to access the phone
> again.

For me also switching phone Bluetooth off and on makes it possible to
create new session form different process, without need to restart
obexd.

Regards,
Mateusz Półrola
