Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 14:19:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ 0/2] Generic GATT client fixes
Message-ID: <20120403111943.GA27222@x220.ger.corp.intel.com>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1333374996-3126-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333374996-3126-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 02, 2012, Anderson Lizardo wrote:
> These are the remaining patches, with fixes from Johan comments.
> 
> Claudio Takahasi (2):
>   attrib: Fix missing Discovery reply when disconnected
>   gattrib: Protect GAttrib when there is a pending write
> 
>  attrib/client.c  |   14 ++++++++++++++
>  attrib/gattrib.c |   12 ++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)

Both patches have been applied. Thanks.

Johan
