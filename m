Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 12:30:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v4 0/8]  DBus OutOfBand API update
Message-ID: <20120814093011.GB1083@x220>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Aug 13, 2012, Szymon Janc wrote:
> changes since V3:
> - remove of DeviceFound signal (rationale below)
> - remove of UUIDs from AddRemoteData dictionary
> - AlreadyPaired -> AlreadyExist error change
> - proposed implementation
> 
> 
> After some more thinking about OOB API I've decided that emitting
> DeviceFound signal when OOB data are provided is not the best thing to do.
> 
> Typical usecase with dbusoob plugin is to provide oob data and either start
> pairing with CreatePairedDevice or wait for incoming pairing request. No need
> to emit DeviceFound as OOB provider is already aware of device address and can
> start pairing. If it doesn't provide pairing agent for device there will be
> fallback to adapter agent (which doesn't need to know anything about OOB
> channel).
> 
> 
> For UUIDs removal is similar - OOB provider already knows which UUIDs are
> supported by remote device and based on that can choose to pair or not. No
> need to provide that to bluetoothd as it would be only used in DeviceFound
> signal anyway.
> 
> Comments are welcome.
> 
> -- 
> BR
> Szymon Janc
> 
> Szymon Janc (8):
>   dbusoob: Update API
>   dbusoob: Simplify remove_remote_data
>   dbusoob: Change ReadLocalData to match new API
>   dbusoob: Change AddRemoteData to match new API
>   dbusoob: Add support for Class in AddRemoteData
>   dbusoob: Add support for Name in AddRemoteData
>   dbusoob: Reply with error if SSP is not supported
>   Update test/test-oob to match new DBus OOB API
> 
>  doc/oob-api.txt   |   59 ++++++++++++++--
>  plugins/dbusoob.c |  193 +++++++++++++++++++++++++++++++++++++++++++++--------
>  src/adapter.c     |    5 ++
>  src/adapter.h     |    2 +
>  src/mgmt.c        |    7 ++
>  src/mgmt.h        |    2 +
>  test/test-oob     |    4 +-
>  7 files changed, 235 insertions(+), 37 deletions(-)

The patches look good to me and have now been applied upstream. Thanks.

Johan
