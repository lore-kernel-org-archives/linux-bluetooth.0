Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <441858.88984.qm@web111402.mail.gq1.yahoo.com>
References: <441858.88984.qm@web111402.mail.gq1.yahoo.com>
Date: Thu, 12 Nov 2009 10:08:33 -0300
Message-ID: <2d5a2c100911120508y38dc967aga78c500e20c075d7@mail.gmail.com>
Subject: Re: Simultaneous outgoing audio streams
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Stanovich <stanmj@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 11, 2009 at 7:54 PM, Mark Stanovich <stanmj@yahoo.com> wrote:
> Sorry if there are multiple messages, it seems that my other email was blocked?
>
> Does anyone know if it is possible to send audio to multiple headsets from one adapter?
>
> I have looked around the source, docs, and the web but have been unable to find an answer.
>
> Currently I can send audio to one headset but once I try to send audio to another headset I get the following messages from bluetoothd:
>
> bluetoothd[17481]: Accepted new client connection on unix socket (fd=22)
> bluetoothd[17481]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
> bluetoothd[17481]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
> bluetoothd[17481]: Audio API: BT_REQUEST <- BT_OPEN
> bluetoothd[17481]: open sco - object=ANY source=ANY destination=00:00:00:00:00:00 lock=write
> bluetoothd[17481]: Audio API: BT_RESPONSE -> BT_OPEN
> bluetoothd[17481]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
> bluetoothd[17481]: State changed /org/bluez/17481/hci0/dev_00_00_00_00_00_00: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
> bluetoothd[17481]: adapter_get_device(00:16:8F:24:6E:A6)
> bluetoothd[17481]: Unable to get service record: Host is down (112)
> bluetoothd[17481]: config failed
> bluetoothd[17481]: sending error Input/output error(5)
> bluetoothd[17481]: Audio API: BT_ERROR -> BT_SET_CONFIGURATION
> bluetoothd[17481]: State changed /org/bluez/17481/hci0/dev_00_00_00_00_00_00: HEADSET_STATE_CONNECTING -> HEADSET_STATE_DISCONNECTED
> bluetoothd[17481]: Unix client disconnected (fd=22)
> bluetoothd[17481]: client_free(0xb8dfa648)
>
> The mac addresses have been changed to all zeros.
>
> Maybe this is a limitation of the hardware or the device driver?
>
> I have set the MaxConnected to greater than 1, actually 15.  Are there any other settings I should be aware of.

For hsp/hfp you need to set MaxConnected, but for a2dp it is required
to change the number of sources/sinks to do the same, both can be
configured via audio.conf. Now about the address, it really seems that
you are using 00:00:00:00:00:00 to connect which explain why you are
getting the host is down error, you can either choose a valid address
or a valid dbus object.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
