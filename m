Return-Path: <cyrus@holtmann.org>
Message-ID: <4FF6E31E.70507@linux.intel.com>
Date: Fri, 06 Jul 2012 15:07:42 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v11 01/12] audio: Move telephony drivers to D-Bus interface
References: <1340900155-26311-1-git-send-email-frederic.danis@linux.intel.com> <1340900155-26311-2-git-send-email-frederic.danis@linux.intel.com> <CANT-zCVZx5QcPkh4Zeru1GvZrOyt2twqB9sy2Zz4KCRZWq_+YQ@mail.gmail.com>
In-Reply-To: <CANT-zCVZx5QcPkh4Zeru1GvZrOyt2twqB9sy2Zz4KCRZWq_+YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Mikel,

On 05/07/2012 16:21, Mikel Astiz wrote:
<snip>

>> +Interaction with the audio component (i.e. PulseAudio) will be done through the
>> +MediaTransport object (passed to telephony agent during NewConnection call).
>
> This is where the interesting part begins: how exactly are you
> planning to do this?
>
> Perhaps I'm missing something but I see no relation between Media
> transport and telephony agent in your patchset. It seems this part of
> the documentation is inconsistent with the code.

The Bluez MediaTransport will act as central point for messages related 
to audio.
e.g. for volume management, PulseAudio or oFono will call SetProperty 
method of MediaTransport which will send a property changed signal.

This behavior is implemented through existing MediaTransport signals and 
patch 8.

> I don't understand your original motivation to do this, but from my
> point of view, something similar would actually be interesting to
> propagate call-states (HFP) from oFono to PulseAudio. This information
> can later be useful for audio routing policies in PulseAudio.

IMO, component implementing audio routing policy should listen oFono 
state changes directly.
On call, it may have to stop current audio playback then route audio:
- from telephony chipset to speaker if there is no HFP connection
- or from telephony chipset to bluetooth device if a HFP endpoint exists
I do not think this needs to pass through BlueZ.

> That being said, I'm not sure if the Telephony API is the proper way
> to address this.

Regards

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation



