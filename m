Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1439404612-2346-1-git-send-email-jpawlowski@google.com>
References: <1439404612-2346-1-git-send-email-jpawlowski@google.com>
Date: Thu, 13 Aug 2015 10:51:47 +0300
Message-ID: <CABBYNZKXOA3kNXQHbdJMah4JS1OGPE8Au9xNFg6V=W_2JP1SWQ@mail.gmail.com>
Subject: Re: [BlueZ RFC] src/device: gatt database persistence
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Aug 12, 2015 at 9:36 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch changes how gatt database for paired devices is stored between
> restarts of bluetoothd. Right now only definition of services is stored.
> After applying this patch whole gatt database will be stored/restored.
>
> Storing whole database can have big impact on reconnection time for paired
> devices, because full discovery can take up to 10 seconds.

There is a TODO for this but it seems that the documentation under
doc/settings-storage.txt outdated. I believe the preferred way to
store is a binary format under cache so the attributes can be
persisted even if the device info is not stored which is the same
design we use for SDP records, note that the code will perform a Read
By Group Type regardless if the database is empty or not to validate
the services on every connection so we need to update the cache every
time an attribute changes.


-- 
Luiz Augusto von Dentz
