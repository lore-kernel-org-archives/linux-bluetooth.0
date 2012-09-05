Return-Path: <cyrus@holtmann.org>
Message-ID: <5046DC86.7030905@ti.com>
Date: Wed, 5 Sep 2012 08:00:54 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: =?UTF-8?B?Sm/Do28gUGF1bG8gUmVjaGkgVml0YQ==?=
	<jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v5 00/14] LE General Connection Establishment procedure
References: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

João,

On 09/04/2012 10:04 PM, João Paulo Rechi Vita wrote:
> This series implement the LE General Connection Establishment procedure
> for LE connections.
>
> If there are LE bonded devices marked for auto connection they are added
> to a connect_list on the adapter. When there is any device on this list
> scan is performed continuously. When a device is found the connect_list
How do we stop this scan ? Do we need to remove all auto-connect settings?

> is checked. If that device is on the list scan is stopped and a
> connection attempt is made to that device.
Do we have a timeout for this ? What happens if we succeed ? Do we start 
scanning again if more devices are set to auto-connect ? What happens 
when we fail a connection ? Do we retry to the same or start scanning 
again ?

>
> If any client tries to perform discovery and the scan for the General
> Connection Establishment procedure is active, the discovery request is
> queued and performed right after the GCEP scan session finishes.
>
I'm am having difficulties understanding the logic here. You say that as 
long as we have bonded devices set for auto-connect, the GCE scan will 
run until a connection is made?. What happens if we do not find any 
device ? Do we scan forever?

This is a bit of a problem - device discovery can not be queued. 
Discovering devices is a user initiated command, and it should run 
whenever a client requires it. When a user requests for a list of 
devices, he expects to get the list. He does not care about background 
logic. The proper logic here is to pause the background scanning, 
discover devices (if LE scan reveals bonded devices that have 
auto-connect setting they should connect and then resume the discovery). 
After Device discovery is terminated, background connect scan should be 
continued.


> This series changes quite a lot the LE connection logic, but we've been
> testing and using this code at INdT for about 4 weeks. Any comments and
> more testing are appreciated.
>
> Claudio Takahasi (6):
>    core: Control connections based on adapter state
>    mgmt: Add LE scanning callback
>    core: Replace interleaved by LE scanning
>    core: Start LE scanning when a device requests
>    core: Queue discovery if scanning is active
>    core: Re-connect for ECONNRESET or ECONNABORTED
>
> João Paulo Rechi Vita (7):
>    mgmt: Print error message when start_discovery fails
>    core: Add compare function for bdaddr in a struct btd_device
>    core: Add a list of LE devices to connect
>    core: Use adapter connect list for LE connections
>    core: Mutually exclude concurrent connections
>    mgmt: Add address type to bonding debug message
>    core: Suspend scanning before connect on pairing
>
> Paulo Alcantara (1):
>    core: Disable unnecessary auto connections
>
>   src/adapter.c | 193 ++++++++++++++++++++++++++++++++++++++++++++-------
>   src/adapter.h |   5 ++
>   src/device.c  | 217 +++++++++++++++++++++++++++++-----------------------------
>   src/device.h  |   2 +
>   src/mgmt.c    |  44 +++++++++++-
>   src/mgmt.h    |   1 +
>   6 files changed, 325 insertions(+), 137 deletions(-)
>


BR,
Chen Ganir

