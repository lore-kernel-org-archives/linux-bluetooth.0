Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Dec 2012 10:31:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/15] device: Retrieve device technology from storage
Message-ID: <20121214083113.GA29347@x220>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Dec 13, 2012, Frédéric Danis wrote:
> ---
>  src/device.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

All patches in this set have been applied. I also applied one extra
patch to convert "Profiles" to "Services" since the value consists of
service UUIDs and not profile UUIDs.

Johan
