Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 19:00:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add support for registering local SDP records
Message-ID: <20131112170040.GA3834@x220.p-661hnu-f1>
References: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 12, 2013, Szymon Janc wrote:
> v3:
>  - fixed Johan comments
> 
> V2:
>  - don't use bt_uuid_t
>  - few bugfixes
> 
> V1 cover:
> This adds support for manipulating local SDP database with
> bt_adapter_add_record and bt_adapter_remove_record functions. Those should
> be called when HAL service is registered or unregistered.
> 
> This also adds DeviceID record as at least 1 local UUID is needed by Android to
> properly handle remote device profiles.
> 
> Last but not least: With this serie it is possible to connect HID device from
> Android UI (Settings application).   \O/
> 
> -- 
> BR
> Szymon Janc
> 
> Marcin Kraglak (3):
>   android: Add and remove sdp records and uuids
>   android: Clear adapter uuids during initialization
>   android: Add support for getting UUIDs property
> 
> Szymon Janc (2):
>   android: Remove not needed include
>   android: Register DeviceID record when adapter is initialized
> 
>  android/adapter.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  android/adapter.h |   3 +
>  2 files changed, 192 insertions(+), 13 deletions(-)

All five patches have been applied. Thanks.

Johan
