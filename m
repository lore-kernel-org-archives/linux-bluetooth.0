Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:13:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/9] Register primary services exported over basic
 rate
Message-ID: <20110414171307.GD7152@jh-x301>
References: <BANLkTikZia_V1pVN_EqF8cpk0xu6GF9ZCg@mail.gmail.com>
 <1302546243-24005-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302546243-24005-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Apr 11, 2011, Claudio Takahasi wrote:
> This patch registers the object paths for primary services exported
> through SDP. PSM, start and end handle information are available in
> the Protocol Descriptor List.
> ---
>  attrib/gatt.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h |    6 ++++
>  src/device.c  |   56 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 139 insertions(+), 1 deletions(-)

All patches in this set have been pushed upstream. Thanks.

Johan
