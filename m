Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: Alan Au <alan.au@netcommwireless.com>
Subject: ConnectProfile continuously failing with InProgress error
Message-ID: <563C3D4B.30102@netcommwireless.com>
Date: Fri, 6 Nov 2015 16:40:27 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been writing an application that invokes Device1.ConnectProfile to 
connect to a remote device. That works fine in the normal case. But 
during development sometimes the app crashes after invoking 
ConnectProfile but before the ConnectProfile async invocation returns. 
In this case bluetoothd seems to sometimes get stuck in a bad state in 
which all subsequent calls to ConnectProfile (or Connect) for the same 
device will continuously return a org.bluez.Error.InProgress failure. I 
need to reboot the box to recover.

This is reproducible with bluetoothctl. By running "connect" to a remote 
device that is not there and then exiting bluetoothctl before the 
connect result comes back. It may take a few tries but eventually 
bluetoothctl will show that any connects to that same device will always 
fail with org.bluez.Error.InProgress.

Example log:

% bluetoothctl
[NEW] Controller 18:F1:45:2F:44:EC [default]
[NEW] Device 00:07:80:31:CC:DD PT/INR Meter
[bluetooth]# connect 00:07:80:31:CC:DD
Attempting to connect to 00:07:80:31:CC:DD
[bluetooth]# exit
[DEL] Controller 18:F1:45:2F:44:EC [default]
% bluetoothctl
[NEW] Controller 18:F1:45:2F:44:EC [default]
[NEW] Device 00:07:80:31:CC:DD PT/INR Meter
[bluetooth]# connect 00:07:80:31:CC:DD
Attempting to connect to 00:07:80:31:CC:DD
Failed to connect: org.bluez.Error.InProgress
[bluetooth]# connect 00:07:80:31:CC:DD
Attempting to connect to 00:07:80:31:CC:DD
Failed to connect: org.bluez.Error.InProgress
[bluetooth]#

Note that this remains the same even after waiting for an hour or more.

I'm using 5.33. Any ideas?

Thanks.

Alan

______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
