Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 14:22:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v10 02/12] audio: Simplify org.bluez.Headset
Message-ID: <20120628112223.GA18038@x220>
References: <1340870617-13532-1-git-send-email-frederic.danis@linux.intel.com>
 <1340870617-13532-3-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1340870617-13532-3-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Jun 28, 2012, Frédéric Danis wrote:
> -int telephony_incoming_call_ind(const char *number, int type)
> -{
> -	struct audio_device *dev;
> -	struct headset *hs;
> -	struct headset_slc *slc;
> -
> -	if (fast_connectable)
> -		manager_set_fast_connectable(TRUE);

Could you explain to me how this fast connectable feature is handled
with the new telephony architecture. I don't remember us having any
discussions about it.

Johan
