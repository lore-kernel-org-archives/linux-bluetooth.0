Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49F89C94.2070604@pook.es>
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301>
	 <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301>
	 <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301>
	 <49F89C94.2070604@pook.es>
Date: Wed, 29 Apr 2009 16:37:16 -0300
Message-ID: <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com>
Subject: Re: bluetoothd 4.37 -> Segmentation fault
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Wed, Apr 29, 2009 at 3:29 PM, Stuart Pook <linux-bluetooth4@pook.es> wrote:
> ^Cbluetoothd[19530]: Removing adapter /org/bluez/19530/hci0
> bluetoothd[19530]: Removing device
> /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
> bluetoothd[19530]: Headset unregistered while device was connected!
> bluetoothd[19530]: telephony-dummy: device 0x4b925a8 disconnected
> bluetoothd[19530]: State changed
> /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98:
> HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
> bluetoothd[19530]: Unregistered interface org.bluez.Headset on path
> /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
> bluetoothd[19530]: unix_device_removed(0x4b925a8)
> ==19530== Invalid read of size 4
> ==19530==    at 0x4EEE6A0: headset_unlock (headset.c:2555)
> ==19530==    by 0x4EE4876: start_close (unix.c:1174)
> ==19530==    by 0x4EE5B5B: unix_device_removed (unix.c:1674)
> ==19530==    by 0x4EE9889: audio_device_unregister (device.c:630)
> ==19530==    by 0x4EE776D: audio_remove (manager.c:759)
> ==19530==    by 0x126799: device_remove (device.c:842)
> ==19530==    by 0x123AA5: adapter_remove (adapter.c:2461)
> ==19530==    by 0x11DEEA: manager_remove_adapter (manager.c:316)
> ==19530==    by 0x489EF06: g_slist_foreach (in
> /usr/lib/libglib-2.0.so.0.2000.1)
> ==19530==    by 0x11DF22: manager_cleanup (manager.c:321)
> ==19530==    by 0x129686: hcid_dbus_exit (dbus-common.c:158)
> ==19530==    by 0x11243F: main (main.c:426)
> ==19530==  Address 0x464 is not stack'd, malloc'd or (recently) free'd
> ==19530== ==19530== Process terminating with default action of signal 11

These looks like a ctrl+c case, although still a bug which should be
investigates this has nothing to do with the crash you have
experienced before.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
