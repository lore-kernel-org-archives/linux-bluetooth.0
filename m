Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 14:38:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
Cc: Koustuv Ghosh <koustuvg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SCORouting to PCM in Desktop
Message-ID: <20110630113825.GA3949@dell.ger.corp.intel.com>
References: <BANLkTi=ku2nnVc0DgduHtxZ6xQvzW-d+zA@mail.gmail.com>
 <20110630092824.GA26690@dell.ger.corp.intel.com>
 <480687D4EEFE7447A2E09AADFF667362049C48F1@nasanexd02c.na.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <480687D4EEFE7447A2E09AADFF667362049C48F1@nasanexd02c.na.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Thu, Jun 30, 2011, Sumangala, Suraj wrote:
> Sometime ago we had a situation where we were testing a BT chip that
> did NOT support SCO over HCI and supported only SCO over PCM.
> 
> The problem was whenever SCO connection was made; my host (Ubuntu)
> sent 2 or 3 SCO packets over HCI to the controller.  The controller
> could not handle these packets as it meant as only a SCO over PCM
> device and crashed.
> 
>  So we had to drop the SCO packets in the HCI transport driver
>  explicitly.  So, when we say in the configuration file that SCO is
>  over PCM should the stack make sure that no SCO packets are sent over
>  HCI?

The user space part of BlueZ isn't actually responsible for sending any
data over SCO at all. Instead this is the job of the audio subsystem
(PulseAudio, GStreamer, ALSA, etc). If you have special hardware that
only supports SCO over PCM you need to tell your audio subsystem about
that. E.g. in PulseAudio there are parameters for giving an ALSA device
to use for reading/writing the audio instead of using the SCO socket
given by BlueZ. I.e. for a system where you have a dedicated PCM line to
the controller you implement a kernel ALSA driver which abstracts this
line to user space and then give the ALSA device exposed by that driver
to PulseAudio (or whatever audio susbystem you might have).

Johan
