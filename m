Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 18 Jan 2013 14:12:56 +0200
Message-ID: <CABBYNZL8R9BEvHY4KFaJ7yCsP_EiVFX8OvTE7J5H1TtqKS95Yw@mail.gmail.com>
Subject: Re: [PATCH 0/5] MAP client: Add missing parameters for GetMessageListing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, Jan 15, 2013 at 3:56 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This patchset adds the missing parameters Text, AttachmentSize and Status
> as well as the filter SubjectLength.
>
> Christian Fetzer (5):
>   obexd: Add parameter SubjectLength to map_list_messages
>   obexd: Move parse_size function in map.c
>   obexd: Add parameter Text to GetMessageListing response
>   obexd: Add parameter AttachmentSize to GetMessageListing response
>   obexd: Add parameter Status to GetMessageListing response
>
>  doc/obex-api.txt   | 20 +++++++++++--
>  obexd/client/map.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 101 insertions(+), 6 deletions(-)
>
> --
> 1.8.1

All 5 patches have been pushed upstream, just need to do a minor fix
to SubjectLength type since D-Bus don't really have uint8 I modified
it to byte.

--
Luiz Augusto von Dentz
