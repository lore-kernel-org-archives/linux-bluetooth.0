Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Mar 2015 09:38:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/4] GATT server API fixes
Message-ID: <20150305073808.GA14922@t440s.lan>
References: <1425506271-20775-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425506271-20775-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Mar 04, 2015, Arman Uguray wrote:
> This patch set includes some minor bug fixes for the GATT server D-Bus API and
> adds the missing implementation for the GattManager1.UnregisterService method.
> 
> Arman Uguray (4):
>   core/adapter: Deduplicate local service UUIDs
>   core/gatt: Fix crash in gatt-database destructor
>   core/gatt: Remove spammy log messages
>   core/gatt: Add UnregisterService and track sender
> 
>  src/adapter.c       | 30 +++++++++++++++++--------
>  src/gatt-database.c | 63 +++++++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 70 insertions(+), 23 deletions(-)

All patches in this set have been applied. Thanks.

Johan
