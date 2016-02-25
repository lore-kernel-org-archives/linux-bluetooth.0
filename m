Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 17:09:56 +1300
From: Kurt McAlpine <kurt@linux.com>
To: linux-bluetooth@vger.kernel.org
Subject: simple-agent troubleshooting/debugging
Message-ID: <20160225040956.GA16677@kurtmc.Eroad.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am having trouble running one the the examples from the bluez repo.
Specifically simple-agent.

I have compiled and installed bluez at commit e074cc1, and I am running Linux
4.5 rc5 at commit 6dc390a.

To get my bluetooth device ready I ran the following commands:

sudo tools/btmgmt -i hci0 power off
sudo tools/btmgmt -i hci0 le on
sudo tools/btmgmt -i hci0 connectable on
sudo tools/btmgmt -i hci0 bredr off
sudo tools/btmgmt -i hci0 name "TEST"
sudo tools/btmgmt -i hci0 advertising on
sudo tools/btmgmt -i hci0 power on

then ran the example:

test/simple-agent

But when I pair my mobile phone with my laptop the simple-agent script does not
ask me for a PIN. It just stays at "Agent registered".

I have attached a copy of the bluetoothd log, just in case I have made
some sort of configuration mistake. bluetoothd was stared with the -E
flag.

Have I made an obvious mistake, can someone point me in the correct
direction to start debugging my issue?

Thanks,
Kurt

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="systemd-output.txt"

Feb 25 16:43:43 kurtmc systemd[1]: Starting Bluetooth service...
Feb 25 16:43:43 kurtmc bluetoothd[446]: Bluetooth daemon 5.37
Feb 25 16:43:43 kurtmc systemd[1]: Started Bluetooth service.
Feb 25 16:43:43 kurtmc bluetoothd[446]: Starting SDP server
Feb 25 16:43:43 kurtmc bluetoothd[446]: Can't load plugin description: /usr/lib/bluetooth/plugins/bluetooth.default.so: undefined symbol: bluetooth_plugin_desc
Feb 25 16:43:43 kurtmc bluetoothd[446]: Can't load plugin description: /usr/lib/bluetooth/plugins/audio.a2dp.default.so: undefined symbol: bluetooth_plugin_desc
Feb 25 16:43:43 kurtmc bluetoothd[446]: Can't load plugin /usr/lib/bluetooth/plugins/audio.sco.default.so: /usr/lib/bluetooth/plugins/audio.sco.default.so: undefined symbol: str2bt_bdaddr_t
Feb 25 16:43:43 kurtmc bluetoothd[446]: Bluetooth management interface 1.11 initialized
Feb 25 16:43:43 kurtmc bluetoothd[446]: Failed to obtain handles for "Service Changed" characteristic
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Error adding Link Loss service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Current Time Service could not be registered
Feb 25 16:43:43 kurtmc bluetoothd[446]: gatt-time-server: Input/output error (5)
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Not enough free handles to register service
Feb 25 16:43:43 kurtmc bluetoothd[446]: Sap driver initialization failed.
Feb 25 16:43:43 kurtmc bluetoothd[446]: sap-server: Operation not permitted (1)
Feb 25 16:48:21 kurtmc systemd[1]: Stopping Bluetooth service...
Feb 25 16:48:21 kurtmc bluetoothd[446]: Terminating
Feb 25 16:48:21 kurtmc systemd[1]: Stopped Bluetooth service.
Feb 25 16:48:21 kurtmc systemd[1]: Starting Bluetooth service...
Feb 25 16:48:21 kurtmc systemd[1]: bluetooth.service: Main process exited, code=exited, status=203/EXEC
Feb 25 16:48:21 kurtmc systemd[1]: Failed to start Bluetooth service.
Feb 25 16:48:21 kurtmc systemd[1]: bluetooth.service: Unit entered failed state.
Feb 25 16:48:21 kurtmc systemd[1]: bluetooth.service: Failed with result 'exit-code'.
Feb 25 16:48:32 kurtmc systemd[1]: Stopped Bluetooth service.
Feb 25 16:48:32 kurtmc systemd[1]: Starting Bluetooth service...
Feb 25 16:48:32 kurtmc bluetoothd[15624]: Bluetooth daemon 5.37
Feb 25 16:48:32 kurtmc bluetoothd[15624]: D-Bus setup failed: Connection ":1.47" is not allowed to own the service "org.bluez" due to security policies in the configuration file
Feb 25 16:48:32 kurtmc systemd[1]: bluetooth.service: Main process exited, code=exited, status=1/FAILURE
Feb 25 16:48:32 kurtmc systemd[1]: Failed to start Bluetooth service.
Feb 25 16:48:32 kurtmc systemd[1]: bluetooth.service: Unit entered failed state.
Feb 25 16:48:32 kurtmc systemd[1]: bluetooth.service: Failed with result 'exit-code'.
Feb 25 16:49:07 kurtmc systemd[1]: Starting Bluetooth service...
Feb 25 16:49:07 kurtmc bluetoothd[15655]: Bluetooth daemon 5.37
Feb 25 16:49:07 kurtmc bluetoothd[15655]: D-Bus setup failed: Connection ":1.50" is not allowed to own the service "org.bluez" due to security policies in the configuration file
Feb 25 16:49:07 kurtmc systemd[1]: bluetooth.service: Main process exited, code=exited, status=1/FAILURE
Feb 25 16:49:07 kurtmc systemd[1]: Failed to start Bluetooth service.
Feb 25 16:49:07 kurtmc systemd[1]: bluetooth.service: Unit entered failed state.
Feb 25 16:49:07 kurtmc systemd[1]: bluetooth.service: Failed with result 'exit-code'.
Feb 25 16:52:17 kurtmc systemd[1]: Stopped Bluetooth service.
Feb 25 16:52:17 kurtmc systemd[1]: Starting Bluetooth service...
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Bluetooth daemon 5.37
Feb 25 16:52:17 kurtmc systemd[1]: Started Bluetooth service.
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Starting SDP server
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Bluetooth management interface 1.11 initialized
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Failed to obtain handles for "Service Changed" characteristic
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: gatt-example-adapter-driver: Input/output error (5)
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Error adding Link Loss service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Current Time Service could not be registered
Feb 25 16:52:17 kurtmc bluetoothd[16236]: gatt-time-server: Input/output error (5)
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Not enough free handles to register service
Feb 25 16:52:17 kurtmc bluetoothd[16236]: Can't listen at channel 8.
Feb 25 16:52:17 kurtmc bluetoothd[16236]: sap-server: Operation not permitted (1)


--dDRMvlgZJXvWKvBx--
