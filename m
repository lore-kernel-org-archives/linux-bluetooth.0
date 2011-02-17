Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 15:50:59 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Clean up in the minimum mtu check
Message-ID: <20110217185059.GB18025@jh-x301>
References: <1297952321-12523-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297952321-12523-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Feb 17, 2011, Sheldon Demario wrote:
> Just a little clean up in the minimum mtu check
> 
> Sheldon Demario (2):
>   Move do_connect() to a common file between interactive.c and
>     gatttool.c
>   Use PSM value to select LE or BR/EDR transport on gatttool
> 
>  Makefile.am          |    3 +-
>  attrib/gatttool.c    |   83 ++++-----------------------------------
>  attrib/gatttool.h    |    4 +-
>  attrib/interactive.c |   25 ++++++++----
>  attrib/utils.c       |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+), 85 deletions(-)
>  create mode 100644 attrib/utils.c

Both patches have been pushed upstream. Thanks.

Johan
