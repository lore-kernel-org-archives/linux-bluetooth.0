Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com
References: <1449572452-5915-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1449572452-5915-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] test: Add device discovery filter
Date: Tue, 19 Jan 2016 10:43:12 +0530
Message-id: <000001d15278$24067090$6c1351b0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: Gowtham Anandha Babu [mailto:gowtham.ab@samsung.com]
> Sent: Tuesday, December 08, 2015 4:31 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH] test: Add device discovery filter
> 
> This patch adds the below mentioned device discovery filters.
> UUIDs, RSSI, Pathloss, Transport.
> ---
>  test/test-discovery | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/test/test-discovery b/test/test-discovery index
9a2c6b9..cea7768
> 100755
> --- a/test/test-discovery
> +++ b/test/test-discovery
> @@ -115,6 +115,18 @@ if __name__ == '__main__':
>  	option_list = [
>  			make_option("-i", "--device", action="store",
>  					type="string", dest="dev_id"),
> +			make_option("-u", "--uuids", action="store",
> +					type="string", dest="uuids",
> +					help="Filtered service UUIDs
> [uuid1,uuid2,...]"),
> +			make_option("-r", "--rssi", action="store",
> +					type="int", dest="rssi",
> +					help="RSSI threshold value"),
> +			make_option("-p", "--pathloss", action="store",
> +					type="int", dest="pathloss",
> +					help="Pathloss threshold value"),
> +			make_option("-t", "--transport", action="store",
> +					type="string", dest="transport",
> +					help="Type of scan to run
> (le/bredr/auto)"),
>  			make_option("-c", "--compact",
>  					action="store_true",
> dest="compact"),
>  			]
> @@ -144,6 +156,26 @@ if __name__ == '__main__':
>  		if "org.bluez.Device1" in interfaces:
>  			devices[path] = interfaces["org.bluez.Device1"]
> 
> +	scan_filter = dict()
> +
> +	if options.uuids:
> +		uuids = []
> +		uuid_list = options.uuids.split(',')
> +		for uuid in uuid_list:
> +			uuids.append(uuid)
> +
> +		scan_filter.update({ "UUIDs": uuids })
> +
> +	if options.rssi:
> +		scan_filter.update({ "RSSI": dbus.Int16(options.rssi) })
> +
> +	if options.pathloss:
> +		scan_filter.update({ "Pathloss":
> dbus.UInt16(options.pathloss) })
> +
> +	if options.transport:
> +		scan_filter.update({ "Transport": options.transport })
> +
> +	adapter.SetDiscoveryFilter(scan_filter)
>  	adapter.StartDiscovery()
> 
>  	mainloop = GObject.MainLoop()
> --
> 1.9.1

