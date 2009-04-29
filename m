Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Apr 2009 19:04:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
Message-ID: <20090429160430.GA25611@jh-x301>
References: <49F8638C.5070205@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <49F8638C.5070205@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

Thanks for the report.

On Wed, Apr 29, 2009, Stuart Pook wrote:
>bluetoothd[6697]: Cleanup plugins
>==6697== ==6697== Invalid read of size 4
>==6697==    at 0x4EE97E7: headset_cancel_stream (in /usr/local/stow/bluez-4.37/lib/bluetooth/plugins/audio.so)
>==6697==    by 0x4EE222A: client_free (in /usr/local/stow/bluez-4.37/lib/bluetooth/plugins/audio.so)
>==6697==    by 0x489EF06: g_slist_foreach (in /usr/lib/libglib-2.0.so.0.2000.1)
>==6697==    by 0x4EE2161: unix_exit (in /usr/local/stow/bluez-4.37/lib/bluetooth/plugins/audio.so)
>==6697==    by 0x4EE19B5: audio_exit (in /usr/local/stow/bluez-4.37/lib/bluetooth/plugins/audio.so)
>==6697==    by 0x11807C: plugin_cleanup (in /usr/local/stow/bluez-4.37/sbin/bluetoothd)
>==6697==    by 0x112AE4: main (in /usr/local/stow/bluez-4.37/sbin/bluetoothd)
>==6697==  Address 0x1c is not stack'd, malloc'd or (recently) free'd
>==6697== ==6697== Process terminating with default action of signal 11 
>(SIGSEGV)

It'd be good if you could get a trace with debug symbols so we see the 
exact line numbers. However, before that could you check with latest git 
if you still experience this crash. There's at least one commit since 4.37 
(7fb4d906c00bf6e2ed03cc3e880bab52b8a984d6) that fixes a crash issue with 
client_free.

Johan
