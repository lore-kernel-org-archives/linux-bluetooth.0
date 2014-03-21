Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 10:44:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 14/62] Replace bt_get_be16() by get_be16()
Message-ID: <20140321084408.GA5834@t440s.lan>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395326607-27068-15-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395326607-27068-15-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 20, 2014, Claudio Takahasi wrote:
> ---
>  android/avrcp-lib.c     |  3 ++-
>  lib/sdp.c               | 25 +++++++++++++------------
>  monitor/sdp.c           | 44 +++++++++++++++++++++++---------------------
>  profiles/audio/avrcp.c  | 30 +++++++++++++++---------------
>  profiles/network/bnep.c |  5 +++--
>  profiles/sap/server.c   |  3 ++-
>  src/sdpd-request.c      | 12 +++++++-----
>  src/sdpd-service.c      |  5 +++--
>  8 files changed, 68 insertions(+), 59 deletions(-)

I've applied patches 1-13 but had to stop with this one due to lib/*
code that should keep using the old functions. I also had to apply an
extra patch to fix an incorrect "const" you had for the destination
pointer in the 32 and 64 bit put functions.

Johan
