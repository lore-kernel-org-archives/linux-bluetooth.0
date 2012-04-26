Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334350864-5509-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org> <1334350864-5509-1-git-send-email-jefferson.delfes@openbossa.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
Date: Thu, 26 Apr 2012 09:35:21 -0400
Message-ID: <CA+_d9qeeyNMYxJAuYLuBv-m3C4b-XHFj1WkxPt=ojM=et1ec8g@mail.gmail.com>
Subject: Re: [PATCHv2 BlueZ 0/2] Add support for find included services
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 13, 2012 at 5:01 PM, Jefferson Delfes
<jefferson.delfes@openbossa.org> wrote:
> This patch series introduces support for find included services.
> The interactive mode of gatttool receives a new command "included" that
> uses gatt_find_included to find these services in given range.
>
> Jefferson Delfes (2):
>  GATT: Add support for find included services
>  gatttool: Add "included" command
>
>  attrib/gatt.c        |  198 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h        |    9 +++
>  attrib/interactive.c |   54 ++++++++++++++
>  3 files changed, 261 insertions(+)
>
> --
> 1.7.10
>

ping
