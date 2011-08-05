Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N+vAPjAmTFLLH-p_iaiPjWF3aV-TAsUn6m8Vnbtfv1=w@mail.gmail.com>
References: <CACbkbULaTeWVtcpFxhUMRMO-r+QuKU8NkX7o5nQBXHKApJbqgQ@mail.gmail.com>
 <CAJdJm_N+vAPjAmTFLLH-p_iaiPjWF3aV-TAsUn6m8Vnbtfv1=w@mail.gmail.com>
From: VISHWANATH KM <a21174@motorola.com>
Date: Fri, 5 Aug 2011 14:54:27 +0530
Message-ID: <CACbkbUJkM37spmZnMT7g3kr3J+T_o0tFZjbNNFV2obcOHZ59Yg@mail.gmail.com>
Subject: Re: Security level for Primary Services discovery during pairing
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As you mentioned in case if we don't want to trigger SMP we should use
CreateDevice, but how do we know before calling CreateDevice or
CreatePairedDevice if remote supports SMP or not. Does bluez exposes
this info to app. We can use LE_Read_Remote_Used_Features only after
LE ACL is established but that is done as part of either CreateDevice
or CreatePairedDevice (bt_io_connect). Please clarify. thx

Regards
Vishwanath

On Fri, Jul 15, 2011 at 5:15 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>
> Hi,
>
> On Thu, Jul 14, 2011 at 1:04 PM, VISHWANATH KM <a21174@motorola.com> wrote:
> > Hi,
> >
> > As per GAP spec section 10.1 Requirements, for both peripheral and
> > central security is optional,
> > in adapter.c create_paired_device_generic  we have
> > device_browse_primary with secure set to TRUE,
> > due to which we are connecting to other device with Security level
> > high, this is causing failure for those
> > peripherals where security is not supported hence those devices
> > doesn't respond to the pairing request initiated
> >
> > device_browse_primary with secure to FALSE goes through, where
> > peripheral initiates Slave security request
> > and SMP just works completes as expected, since security is optional,
> > should the secure for device_browse_primary
> > be set to FALSE in create_paired_device_generic ? please let us know
> > your comments. thx
>
> You should use "CreateDevice" (not "CreatePairedDevice") if you don't
> want to trigger SMP pairing. See doc/adapter-api.txt for details on
> each method, and create_device() in src/adapter.c for the
> implementation.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
