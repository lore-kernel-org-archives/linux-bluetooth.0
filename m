Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marc Anders <andersm223@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ port to Android version 4.4.2
Date: Fri, 03 Jun 2016 20:41:19 +0200
Message-ID: <8278542.p6CNIACTn7@ix>
In-Reply-To: <CALmZcgaiS_nTdUtFae3rrB+Z9Lef+1V=GdhFjnC-rtPw=pRGvA@mail.gmail.com>
References: <CALmZcgaiS_nTdUtFae3rrB+Z9Lef+1V=GdhFjnC-rtPw=pRGvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Monday 30 May 2016 19:42:06 Marc Anders wrote:
> Hello,
> 
> I am trying to port BlueZ to an Android 4.4.2 kernel.  I followed the
> instructions I found on the following site:
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README
> 
> I have the project compiling and was able to flash to the board.  When
> the bluetooth system boots up however the Bluez system times out
> during its init with the following error logs:
> 
> 05-26 09:05:36.381 D/BlueZ   ( 1828):
> external/bluetooth/bluez/android/hal-bluetooth.c:open_bluetooth()
> 05-26 09:05:36.381 D/BlueZ   ( 1828):
> external/bluetooth/bluez/android/hal-bluetooth.c:get_bluetooth_interface()
> 05-26 09:05:36.401 D/BlueZ   ( 1828):
> external/bluetooth/bluez/android/hal-bluetooth.c:init()
> 05-26 09:05:36.551 I/bluetoothd( 1893): Bluetooth daemon 5.39
> 05-26 09:05:36.551 I/bluetoothd( 1893): Starting SDP server
> 05-26 09:05:36.551 I/bluetoothd( 1893): Bluetooth management interface
> 1.3 initialized
> 05-26 09:05:41.541 I/bluetoothd( 1893): Stopping SDP server
> 05-26 09:05:41.541 I/bluetoothd( 1893): Exit
> 05-26 09:05:46.431 E/BlueZ   ( 1828): bluetoothd connect timeout
> 
> Looking further into what is causing the bluetoothd to time out I've
> found that calling poll() within the accept_connection() function
> within hal-bluetooth.c is what causes this.  Using the process
> described in the above readme I did port over the new epoll_create1()
> and ppoll() calls from
> https://github.com/bluez-android/aosp_platform_bionic.  I'm trying to
> determine what the poll() function is calling out to that is causing
> this to timeout.
> 
> Any assistance is appreciated,

bluetoothd from BlueZ for Android requires BT adapter to be ready before it is 
started. Typically on Android device this done by hciattach or brcm_patchram.

To do this automatically I suggest to have hciattach service that is started 
is bluetoothd service is started. This should be enough since bluetoothd wait  
5 seconds before shutting down. You can check at https://github.com/bluez-android how this was done for Nexus devices.

ie.

on property:init.svc.bluetoothd=running
    start hciattach

on property:init.svc.bluetoothd=stopped
    stop hciattach


-- 
pozdrawiam
Szymon Janc
