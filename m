Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 13:03:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v4 0/6] Add org.bluez.Telephony interface
Message-ID: <20111212110308.GA12769@x220>
References: <1323686954-11899-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1323686954-11899-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Dec 12, 2011, Frédéric Danis wrote:
> First patch add the new org.bluez.Telephony interface and remove
> functions related to AT parsing from audio/headset.c.
> 
> Second, third and fourth patches remove the telephony drivers (dummy,
> maemo5, maemo6 and ofono), functions used by telephony drivers and no
> more needed methods of org.bluez.Headset interface.
> 
> Fifth patch move the HS/HF AG rfcomm servers from audio/manager.c to
> audio/telephony.c.
> Rfcomm server for a specific profile is only started (and the related
> sdp records advertised) when an agent register for it.
> 
> Sixth patch passes MediaTransport path to the agent during
> NewConnection mehod call. So, telephony agent will be able to set NREC
> and ringtone, which can in turn notify Pulse Audio of property changed.

Could you please add these descriptions (and possibly even more thorough
explanations) to the commit messages of each patch. We really should try
to avoid one-line commit messages for all but the most trivial patches
(and even for those I wont complain if you have longer explanations).
Remember that the summary line should be a very short summary of *what*
the patch does whereas the rest of the message can elaborate on it (if
necessary) but more importantly explain *why* the patch was needed and
how it goes about solving some issue.

Johan
