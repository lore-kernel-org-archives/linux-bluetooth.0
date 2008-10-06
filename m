Return-Path: <cyrus@holtmann.org>
Message-Id: <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48E91E6F.1030202@pook.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> Invalid read of size 4
Date: Mon, 6 Oct 2008 10:47:35 +0200
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Oct 5, 2008, at 22:07, Stuart Pook wrote:
> bluetoothd[15123]: connect(): Connection timed out (110)
> ==15123== Invalid read of size 4
> ==15123==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
> ==15123==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/ 
> libdbus-1.so.3.4.0)
> ==15123==    by 0x49155C0: dbus_message_new_error (in /usr/lib/ 
> libdbus-1.so.3.4.0)
> ==15123==    by 0x1361D: error_common_reply (in /usr/local/stow/ 
> bluez-4.11/sbin/bluetoothd)
> ==15123==    by 0x4ED9D2C: error_connection_attempt_failed (in /usr/ 
> local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
> ==15123==    by 0x4EDAEA2: rfcomm_connect_cb (in /usr/local/stow/ 
> bluez-4.11/lib/bluetooth/plugins/audio.so)
> ==15123==    by 0x2165E: connect_cb (in /usr/local/stow/bluez-4.11/ 
> sbin/bluetoothd)
> ==15123==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
> ==15123==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/ 
> libglib-2.0.so.0.1600.6)
> ==15123==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
> ==15123==    by 0x4881D71: g_main_loop_run (in /usr/lib/ 
> libglib-2.0.so.0.1600.6)
> ==15123==    by 0xA410: main (in /usr/local/stow/bluez-4.11/sbin/ 
> bluetoothd)
> ==15123==  Address 0x464c45b3 is not stack'd, malloc'd or (recently)  
> free'd

Thanks for the valgrind report. It definitely gives some hints at  
what's going on. Apparently there's a bug in one error handling code  
path of the rfcomm_connect_cb function. The weird thing here is that  
the code path (which calls error_connection_attempt_failed) should  
only be taken if the connection attempt was triggered by a D-Bus  
message which is not the case for you (it's the alsa sound player that  
triggers it, right?). I fixed some issues related to the connection  
handling in git but none of it seemed to be directly related to the  
backtrace you gave. Could you give the current git a try (git clone  
git://git.kernel.org/pub/scm/bluetooth/bluez.git; cd bluez; ./ 
bootstrap-configure && make)? Also, try to run bluetoothd directly  
from the source tree (src/.libs/bluetoothd) so that valgrind can pick  
up the correct file names and line numbers as well.

Regarding why this code path is taken, it seems like your alsa  
application gives up before the bluetooth connection has been created.  
When bluetoothd sees that the alsa client exited it calls close() on  
the connecting RFCOMM socket which in effect terminates the connection  
creation and causes rfcomm_connect_cb to be called with an error code.  
Why your application gives up prematurely is still unclear to me.

Johan


