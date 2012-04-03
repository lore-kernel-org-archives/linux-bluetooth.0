Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Apr 2012 13:52:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 1/6] att: add remote btd_device to ATT read/write
 callbacks
Message-ID: <20120403105239.GA26586@x220.ger.corp.intel.com>
References: <1333393962-21394-1-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333393962-21394-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Mon, Apr 02, 2012, Arik Nemtsov wrote:
> This allows us to identify the remote device that made the ATT
> read/write.
> ---
>  attrib/att-database.h  |   43 +++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h           |   20 --------------------
>  attrib/gatt-service.c  |    1 +
>  plugins/gatt-example.c |    4 +++-
>  proximity/reporter.c   |    1 +
>  src/attrib-server.c    |   20 +++++++++++++++-----
>  time/server.c          |    7 +++++--
>  7 files changed, 68 insertions(+), 28 deletions(-)
>  create mode 100644 attrib/att-database.h

All patches in this set have been applied. Thanks.

Johan
