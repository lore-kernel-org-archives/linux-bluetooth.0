Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jan 2012 21:43:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/3] Fix not showing name if first EIR has no name
 info
Message-ID: <20120117194300.GB29544@x220.P-661HNU-F1>
References: <1326817082-6787-1-git-send-email-anderson.lizardo@openbossa.org>
 <1326817082-6787-3-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326817082-6787-3-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Jan 17, 2012, Anderson Lizardo wrote:
> Some devices may not advertise their name right on the first EIR data
> sent (e.g. LE devices where name is set on either advertises or scan
> responses, but not both). Given that the "found devices" cache does not
> refresh the name on each EIR received, the UI may never show the name
> during a discovery session.
> 
> This fix improves the Discovery UI by showing names immediately as they
> are received. This works by emitting DeviceFound signals when the name
> is received, even if RSSI stays the same.
> 
> Further discovery sessions will use the stored complete name, as usual.
> ---
>  src/adapter.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Applied. Please do a git pull and check that the eir_parse function is
now both readable and correct.

Johan
