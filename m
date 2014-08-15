Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Aug 2014 10:53:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/3] shared/att: Handle disconnects.
Message-ID: <20140815075313.GB28774@t440s.lan>
References: <1407983276-22573-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407983276-22573-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Aug 13, 2014, Arman Uguray wrote:
> * v3:
>     - Seperated the changes to io-mainloop, bt_att_set_close_on_unref, and
>       disconnect handling into separate patches.
> 
> Arman Uguray (3):
>   shared/io-mainloop: Increment the ref count inside io_callback.
>   shared/att: Use io_set_close_on_destroy.
>   shared/att: Handle disconnects.
> 
>  src/shared/att.c         | 85 +++++++++++++++++++++++++++++++++++-------------
>  src/shared/att.h         |  5 +++
>  src/shared/io-mainloop.c |  5 +++
>  3 files changed, 73 insertions(+), 22 deletions(-)

All three patches have been applied. Thanks.

Johan
