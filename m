Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 13:09:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] audio: permit concurrent use of AG and HF roles
Message-ID: <20120628100951.GA6987@x220>
References: <1340374285-29720-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1340374285-29720-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Jun 22, 2012, Frédéric Dalleau wrote:
> If a device supports both HF and AG roles, then if a SCO connection related
> to AG profile happens, the connection is rejected because HF is not connected.
> One consequence is pulseaudio failing to load bluetooth module.
> ---
>  audio/main.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks (after fixing your commit message width to stay at max
72 chars).

Johan
