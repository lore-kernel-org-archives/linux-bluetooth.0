Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Nov 2011 16:15:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
Message-ID: <20111122141502.GD15357@aemeltch-MOBL1>
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Nov 22, 2011 at 03:01:22PM +0100, Frédéric Danis wrote:
> Hello,
> 
> I am working on this set of patches.
> 
> Replace telephony drivers for HeadSet/HandsFree Profiles by a new DBus
> interface (org.bluez.Telephony).
> External applications, which should implement AT parsing and telephony
> part of HeadSet or HandsFree Profiles, will have to register a telephony
> agent using this new interface.
> 
> 
> First patch add the new org.bluez.Telephony interface and remove
> functions related to AT parsing from audio/headset.c.
> 
> Second patch remove the telephony drivers (dummy, maemo5, maemo6

is this really needed?

Best regards 
Andrei Emeltchenko 

> and ofono), functions used by telephony drivers and no more needed
> methods of org.bluez.Headset interface.
> 
> 
> What I would like to do to continue is:
> - move rfcomm servers from audio/manager.c to audio/telephony.c, so
> servers are started only when a telephony agent is registered. This
> should also replace audio/gateway.c.
> - pass MediaTransport object in NewConnection method so telephony agent
> will be able to set NREC and ringtone, which can in turn notify Pulse
> Audio of property changed.
> 
> 
> Any comments appreciated
> 
> Regards
> 
> Fred
> 
> Frédéric Danis (2):
>   audio: Move tel drivers to DBus interface
>   audio: Remove tel drivers
> 
>  Makefile.am              |   17 +-
>  audio/headset.c          | 1517 +-------------------------------
>  audio/headset.h          |    7 +-
>  audio/manager.c          |    4 +-
>  audio/telephony-dummy.c  |  433 ---------
>  audio/telephony-maemo5.c | 2104 --------------------------------------------
>  audio/telephony-maemo6.c | 2201 ----------------------------------------------
>  audio/telephony-ofono.c  | 1638 ----------------------------------
>  audio/telephony.c        |  494 +++++++++++
>  audio/telephony.h        |  196 +----
>  audio/transport.c        |   10 +
>  audio/unix.c             |    2 +
>  doc/audio-api.txt        |   99 +++
>  13 files changed, 631 insertions(+), 8091 deletions(-)
>  delete mode 100644 audio/telephony-dummy.c
>  delete mode 100644 audio/telephony-maemo5.c
>  delete mode 100644 audio/telephony-maemo6.c
>  delete mode 100644 audio/telephony-ofono.c
>  create mode 100644 audio/telephony.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
