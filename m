Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jun 2014 10:57:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] core: Fix stop_passive_scanning_complete()
Message-ID: <20140626075717.GA21340@t440s.lan>
References: <20140625173804.13C85100934@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140625173804.13C85100934@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Wed, Jun 25, 2014, Petri Gynther wrote:
> Consider MGMT_STATUS_REJECTED as success for stop_passive_scanning().
> MGMT_STATUS_REJECTED may be returned from kernel because the passive
> scan timer had expired in kernel and passive scan was disabled just
> around the time we called stop_passive_scanning().
> 
> This issue can be seen with BLE HoG devices trying to reconnect to BlueZ:
> bluetoothd[931]: src/adapter.c:device_found_callback() hci0 addr ...
> bluetoothd[931]: src/device.c:device_set_legacy() legacy 0
> bluetoothd[931]: src/device.c:device_set_rssi() rssi -75
> bluetoothd[931]: src/adapter.c:stop_passive_scanning()
> bluetoothd[931]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
> bluetoothd[931]: src/adapter.c:trigger_passive_scanning()
> bluetoothd[931]: src/adapter.c:stop_passive_scanning_complete() status 0x0b (Rejected)
> bluetoothd[931]: Stopping passive scanning failed: Rejected
> ---
>  src/adapter.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

All three of these patches have been applied. Thanks.

Johan
