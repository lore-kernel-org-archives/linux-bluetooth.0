Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Aug 2010 23:10:18 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
 "Device Found" signal.
Message-ID: <20100807031018.GA481@jh-x301>
References: <20100806173042.GA28198@jh-x301>
 <1281119724-28882-1-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281119724-28882-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Fri, Aug 06, 2010, Inga Stotland wrote:
> If service UUIDs are present in EIR, they are written to
> "device properties" dictionary  when emitting "Device Found" signal.
> This allows peek at available services offered by a remote device
> without establishing SDP connection.
> ---
>  src/adapter.c  |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  src/adapter.h  |    4 +-
>  src/dbus-hci.c |    6 ++--
>  3 files changed, 110 insertions(+), 8 deletions(-)

The patch is now upstream. Thanks!

Johan
