Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 14:54:58 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix regression causing crash in 3-way calling
Message-ID: <20101208125455.GA23047@jh-x301>
References: <1291809471-806-1-git-send-email-dmitriy.paliy@nokia.com>
 <1291809471-806-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291809471-806-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Dec 08, 2010, Dmitriy Paliy wrote:
> Fix obexd crash in 3-way calling scenario. Crash happens when there
> is redialed second incoming call. Cache for the PBAP session is
> already created at that moment, but PBAP object is destroyed. Crash
> happens when object is dereferenced in vobject_list_open.
> 
> Therefore, PBAP object has to be created before any attempt to write
> cached data to buffer associated to this object.
> 
> However, cache_ready_notify function, which is invoked in
> vobject_vcard_open for valid cache case, sends also PBAP object data
> via callback function to obex.c and written to OBEX stream as GET
> response in handle_async_io handler function.
> 
> A new response is sent to OBEX stream after cache_ready_notify exists
> to vobject_list_open function, which is callback function for
> obex_mime_type_driver. Such leads to undefined befavior. Therefore,
> cache_ready_notify is splitted in two cache_ready_notify and
> generate_response functions.
> 
> generate_response fills data to buffer and returns error, if any,
> while cache_ready_notify notifies OBEX core to write this data to
> stream.
> 
> In order to avoid writing to stream twice, cache_ready_notify is
> replaced by generate_response in vobject_list_open. As a result,
> PBAP buffer data is generated from existing cache and sent to
> stream upon start of OBEX stream after vobject_list_open exits.
> ---
>  plugins/pbap.c |   98 +++++++++++++++++++++++++++++++-------------------------
>  1 files changed, 54 insertions(+), 44 deletions(-)

Pushed upstream. Thanks.

Johan
