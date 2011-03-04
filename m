Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:49:19 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add offset option to characteristic read by handle
Message-ID: <20110304184919.GE21452@jh-x301>
References: <1299085748-5328-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299085748-5328-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Mar 02, 2011, Sheldon Demario wrote:
> Some tests require an arbitrary offset.
> ---
>  attrib/client.c      |   10 +++++-----
>  attrib/gatt.c        |   15 +++++++++++----
>  attrib/gatt.h        |    4 ++--
>  attrib/gatttool.c    |    5 ++++-
>  attrib/interactive.c |   16 ++++++++++++++--
>  5 files changed, 36 insertions(+), 14 deletions(-)

Pushed upstream. Thanks.

Johan
