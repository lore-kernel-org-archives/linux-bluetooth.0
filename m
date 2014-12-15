Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com>
References: <1415351073-4362-1-git-send-email-chao.jie.gu@intel.com>
Date: Mon, 15 Dec 2014 08:41:05 -0800
Message-ID: <CAHrH25T6BccZaza2SJvWLL70FQWoEXWkAmRcE=5cfE-WGkcUew@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] support signed write command
From: Arman Uguray <armansito@chromium.org>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

> On Fri, Nov 7, 2014 at 1:04 AM, Gu Chaojie <chao.jie.gu@intel.com> wrote:
> * This patch set give user dedicated command to set CSRK option and seperate from signed write command implementation in the previous patch
> * Remove the valid_csrk flag, use struct signed_write_info make implementation more clear and simple
> * signed_counter will initialize when CSRK be set, remove signed_counter initialization in bt_att_new procedure.
>
> Gu Chaojie (3):
>   shared/att.c:Add signed command outgoing and CSRK function
>   shared/gatt-client:Add CSRK part to support signed write
>   tools/btgatt-client:Add signed write with CSRK option
>
>  src/shared/att-types.h   |   3 +
>  src/shared/att.c         | 146 ++++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/att.h         |  12 ++++
>  src/shared/gatt-client.c |  21 +++++--
>  src/shared/gatt-client.h |   4 ++
>  tools/btgatt-client.c    |  69 +++++++++++++++++++++-
>  6 files changed, 245 insertions(+), 10 deletions(-)
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sending a gentle ping on these patches, since they haven't received a
lot of attention for a couple of months. What's the status of Signed
Writes here? These will be more relevant for Android now than they
will initially be for desktop.

Thanks,
Arman
