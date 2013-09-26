Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Thu, 26 Sep 2013 16:01:12 +0300
Message-ID: <CABBYNZ+_-3akDp7r7Q3fbeAveiQS3tJ7CS1P71qsTEnxQu8rOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] obexd: Fix setting message folder
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Sep 23, 2013 at 12:24 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This fixes an issue that the folder property for messages was set incorrectly
> when ListMessages got called with a subfolder parameter.
>
> Calling ListMessages within /telecom/msg for the subfolder inbox would set the
> folder property to /telecom/msg instead of /telecom/msg/inbox.
>
> The patchset therefore changes map_msg_create to not set the folder property
> to the current folder, but to a folder given as parameter. This change will be
> needed as well for new message notifications (that can indicate new messages
> for any folder).
>
> In addition I've updated the documentation to clarify that the folder property
> for ListMessages and PushMessage can be used only for a subfolder of the
> current folder. It's not possible to specify an absolute or relative path.
>
> --
> v2: Store folder in MAP pending request
>
> Christian Fetzer (4):
>   obexd: Add folder property to map_msg_create
>   obexd: Fix setting message folder for relative folder in ListMessages
>   obexd: Clarify the folder property of ListMessages
>   obexd: Clarify the folder property of PushMessage
>
>  doc/obex-api.txt   |  8 +++++---
>  obexd/client/map.c | 22 +++++++++++++++++++---
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> --
> 1.8.3.4

All 4 patches are now applied, but Ive done some changes to
get_absolute_folder so to have less lines breaks so it looks more
readable now.


-- 
Luiz Augusto von Dentz
