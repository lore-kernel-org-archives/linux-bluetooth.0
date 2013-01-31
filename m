Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Ben Klopfenstein <benklop@gmail.com>
Date: Wed, 30 Jan 2013 21:51:58 -0700
Message-ID: <CAJzW9NCoE7xO=dMJEYkAVKk8QtQaopNkZb2JC51PbL3+-asPUQ@mail.gmail.com>
Subject: Cannot get bluetooth audio (A2DP or SCO) with an LG tone+ HBS-730 headset
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have been trying for  while now to get a new headset I purchased to
work with bluez and pulseaudio. I can get other A2DP devices to work,
so I know my setup is sane, and I have this issue with multiple
laptops running the most recent bluez/kernel.

When attempting to connect to the headset, I get the following in the logs:

Jan 30 20:37:36 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Endpoint registered: sender=:1.55 path=/MediaEndpoint/HFPAG
Jan 30 20:37:36 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Endpoint registered: sender=:1.55 path=/MediaEndpoint/HFPHS
Jan 30 20:37:36 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Endpoint registered: sender=:1.55 path=/MediaEndpoint/A2DPSource
Jan 30 20:37:36 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Endpoint registered: sender=:1.55 path=/MediaEndpoint/A2DPSink
Jan 30 20:37:53 ben-HP-Pavilion-dm4-Notebook-PC ntpdate[3446]: step
time server 91.189.94.4 offset 11.616705 sec
Jan 30 20:37:53 ben-HP-Pavilion-dm4-Notebook-PC kernel: [  187.053807]
userif-2: sent link up event.<7>[  196.133807] /dev/vmmon[0]:
HostIFReadUptimeWork: detected settimeofday: fixed uptimeBase old
18445384470424071485 new 18445384470412454752 attempts 1
Jan 30 21:12:50 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Unable to get service record: Host is down (112)
Jan 30 21:13:10 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]: Badly
formated or unrecognized command: AT+BIA=0,0,0,1,1,1,0
Jan 30 21:13:12 ben-HP-Pavilion-dm4-Notebook-PC bluetoothd[983]:
Operation not supported (95)
Jan 30 21:13:12 ben-HP-Pavilion-dm4-Notebook-PC pulseaudio[3486]:
[pulseaudio] bluetooth-util.c: Failed to acquire transport fd:
Input/output error
Jan 30 21:13:12 ben-HP-Pavilion-dm4-Notebook-PC pulseaudio[3486]:
[pulseaudio] module.c: Failed to load module "module-bluetooth-device"
(argument: "address="00:18:6B:15:AC:DC"
path="/org/bluez/983/hci0/dev_00_18_6B_15_AC_DC""): initialization
failed.
Jan 30 21:13:12 ben-HP-Pavilion-dm4-Notebook-PC kernel: [ 2311.875574]
input: 00:18:6B:15:AC:DC as /devices/virtual/input/input12


My suspicion is that this headset, which supports some unusual
features like the APT-X proprietary codec and multiple simultaneous
A2DP connections from different devices may be sending some unexpected
response. I'm not sure where to look next for this. Any suggestions
what might be going on, or how to troubleshoot this further?
