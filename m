Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Mar 2010 10:45:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Francisco Alecrim <francisco.alecrim@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
Message-ID: <20100329074539.GA20839@jh-x301>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 26, 2010, Francisco Alecrim wrote:
> Emitting Adapter.PropertyChanged signal when UUIDs change. D-Bus message
> to inform that adapter properties changed.
> ---
>  src/adapter.c       |   75 ++++++++++++++++++++++++++++++++++++++++++++------
>  src/adapter.h       |    1 +
>  src/sdpd-database.c |    3 ++
>  3 files changed, 70 insertions(+), 9 deletions(-)

Thanks for the patches. In principle they look good, but I haven't
applied them yet due to one thing that looks a bit strange: both the SDP
server record UUID (0x1000) as well as the public browse group UUID
(0x1001) always show up in the UUIDs list. I wonder if there'd be any
clean way to avoid getting them into the list. Marcel, do you have any
idea about this or is it even a problem that these UUIDs are always in
the list?

Johan
