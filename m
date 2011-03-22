Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Mar 2011 20:11:38 +0100
Message-ID: <AANLkTi=R7kt2tFTpj_RBBbnoPBGNT90K0grshUSJNVnD@mail.gmail.com>
Subject: android: bluetoothd hung after bluetooth had been turned off
From: Vitaly Wool <vitalywool@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings,

I'd got a nasty hang in my Android phone when I turned bluetooth off
from the UI while the music was playing over bluetooth connection.

After some investigation I concluded that bluetoothd was stuck. It was
not able to perform the a2dp_cleanup() and bluetooth_close().
bluetoothd call stack analysis showed that poll function was called
with an infinite timeout argument (-1).

The timeout is initialized in g_main_context_prepare() to -1. As far
as I understand, it may then be set either to the timeout value
provided by source->source_funcs->prepare(), or to 0 if there is data
pending. But as long as all the channels are g_io_unix, the timeout
will remain set to -1 if there's no data ATM.

I guess if the interface is taken down, it is expected that poll
function quits with POLLERR set in revents but that hasn't happened.
Isn't it reasonable to still have a timeout for poll to avoid such
situations?

The Android version is Gingerbread so BlueZ is 4.69.

Any help would be greatly appreciated.

Thanks,
   Vitaly
