Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 23 Aug 2017 21:38:38 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: Read by Group Type is denied when issued before Pairing is finsihed
Message-ID: <20170823193838.GD7309@annapurna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I have stumbled upon a problem with one of the BLE devices that I have
on my desk. BlueZ (bluetoothctl) failed to discover the primary services
and the error returned by the Read by Group type request was
"Insufficient Authentication". It did work when using gatttool though.

I have tracked it down and realized that if calling the
bt_gatt_discover_all_primary_services is delayed until after the pairing
is finished then the primary services are discovered without any issues.

The simplified bt for bt_gatt_discover_all_primary_services is:

(gdb) bt
#0  discover_services
#1  bt_gatt_discover_primary_services
#2  bt_gatt_discover_all_primary_services 
#3  exchange_mtu_cb

Now, what would be the best way of approaching this. Calling it could be
delayed with a timer but would it be an optimal solution - thoughts?

Thanks,
K
