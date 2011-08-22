Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 10:54:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2] Increase timeout before initiating AVDTP
 connection
Message-ID: <20110822075456.GC31673@dell>
References: <1313161215.2254.6.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313161215.2254.6.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Fri, Aug 12, 2011, Peter Hurley wrote:
> AVDTP_CONNECT_TIMEOUT controls the delay between HSP/HFP
> connection establishment and AVDTP signal channel establishment.
> The original value of 1 sec. is too short to avoid racing for AVDTP
> connection establishment (eg., if the device continues to configure
> the HFP service level connection with add'l AT cmds).
> 
> Some devices have broken AVDTP implementations that just cannot
> handle the race conditions that arise if both devices are attempting
> stream establishment at the same time. However, these conditions arise
> only when the remote device is the ACL initiator (and in practice, the
> RFCOMM initiator as well).  This fix bumps out the timeout value only
> when the headset has initiated the link.
> ---
> 
> v2: Follow established naming convention
> 
>  audio/device.c  |    9 ++++++++-
>  audio/headset.c |   17 +++++++++++++++++
>  audio/headset.h |    4 ++++
>  audio/manager.c |    1 +
>  4 files changed, 30 insertions(+), 1 deletions(-)

The patch has been applied, but could you please make sure you send
clean patches in the future. Now I got this from git:

/home/jh/src/bluez/.git/rebase-apply/patch:19: trailing whitespace.
#define AVDTP_CONNECT_TIMEOUT_BOOST 1
/home/jh/src/bluez/.git/rebase-apply/patch:27: trailing whitespace.
	guint timeout = AVDTP_CONNECT_TIMEOUT;
/home/jh/src/bluez/.git/rebase-apply/patch:36: trailing whitespace.
	/* if the headset is the HSP/HFP RFCOMM initiator, give the headset
/home/jh/src/bluez/.git/rebase-apply/patch:37: trailing whitespace.
	   time to initiate AVDTP signalling (and avoid further racing) */
/home/jh/src/bluez/.git/rebase-apply/patch:38: trailing whitespace.
	if (dev->headset && headset_get_rfcomm_initiator(dev))
warning: squelched 25 whitespace errors
warning: 1 line applied after fixing whitespace errors.

Johan
