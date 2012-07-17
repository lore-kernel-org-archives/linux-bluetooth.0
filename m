Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 11:08:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v12 01/13] audio: Move telephony drivers to D-Bus
 interface
Message-ID: <20120717080817.GA368@x220>
References: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com>
 <1342090438-20434-2-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342090438-20434-2-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Jul 12, 2012, Frédéric Danis wrote:
>  Makefile.am                    |   16 +-
>  audio/headset.c                |  676 +++-------------------------------------
>  audio/headset.h                |    3 +
>  audio/manager.c                |   13 +-
>  audio/telephony.c              |  595 +++++++++++++++++++++++++++++++++++
>  audio/telephony.h              |   25 +-
>  doc/assigned-numbers.txt       |    1 +
>  doc/audio-api.txt              |   90 ++++++
>  doc/audio-telephony-design.txt |  106 +++++++

Could you split the doc changes into its own patch? You'll need to fix
that part anyway due to the addition of doc/supported-features which
conflicts with your Makefile.am changes.

Johan
