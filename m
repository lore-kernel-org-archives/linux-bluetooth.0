Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:13:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/7] ATT connection management improvements
Message-ID: <20120214121330.GA10506@x220.ger.corp.intel.com>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Feb 09, 2012, Claudio Takahasi wrote:
> The following patches are cleaning and consolidating ATT connection
> management in device.c
> 
> Claudio Takahasi (6):
>   device: Consolidate ATT connection management
>   device: Fix notifying ATTIO drivers when browsing
>   attrib-server: Remove GAttrib disconnect callback
>   device: Remove GAttrib disconnect callback
>   device: Add common ATT connection cleanup function
>   GAttrib: Remove unused function
> 
> Vinicius Costa Gomes (1):
>   device: Fix trying to connect if already connected
> 
>  attrib/gattrib.c    |   22 +----
>  attrib/gattrib.h    |    3 -
>  src/attrib-server.c |   30 ++++--
>  src/attrib-server.h |    2 +-
>  src/device.c        |  253 ++++++++++++++++++++++++++++-----------------------
>  5 files changed, 160 insertions(+), 150 deletions(-)

All patches have been applied. Thanks.

Johan
