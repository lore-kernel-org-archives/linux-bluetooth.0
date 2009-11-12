Return-Path: <cyrus@holtmann.org>
Message-ID: <697456.15025.qm@web111405.mail.gq1.yahoo.com>
Date: Thu, 12 Nov 2009 05:20:25 -0800 (PST)
From: Mark Stanovich <stanmj@yahoo.com>
Subject: Re: Simultaneous outgoing audio streams
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100911120508y38dc967aga78c500e20c075d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > Does anyone know if it is possible to send audio to multiple headsets from one adapter?
> >
> > I have looked around the source, docs, and the web but have been unable to find an answer.
> >
> > Currently I can send audio to one headset but once I
> try to send audio to another headset I get the following
> messages from bluetoothd:
> >
> > bluetoothd[17481]: Accepted new client connection on
> unix socket (fd=22)
> > bluetoothd[17481]: Audio API: BT_REQUEST <-
> BT_GET_CAPABILITIES
> > bluetoothd[17481]: Audio API: BT_RESPONSE ->
> BT_GET_CAPABILITIES
> > bluetoothd[17481]: Audio API: BT_REQUEST <-
> BT_OPEN
> > bluetoothd[17481]: open sco - object=ANY source=ANY
> destination=00:00:00:00:00:00 lock=write
> > bluetoothd[17481]: Audio API: BT_RESPONSE ->
> BT_OPEN
> > bluetoothd[17481]: Audio API: BT_REQUEST <-
> BT_SET_CONFIGURATION
> > bluetoothd[17481]: State changed
> /org/bluez/17481/hci0/dev_00_00_00_00_00_00:
> HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
> > bluetoothd[17481]:
> adapter_get_device(00:16:8F:24:6E:A6)
> > bluetoothd[17481]: Unable to get service record: Host
> is down (112)
> > bluetoothd[17481]: config failed
> > bluetoothd[17481]: sending error Input/output
> error(5)
> > bluetoothd[17481]: Audio API: BT_ERROR ->
> BT_SET_CONFIGURATION
> > bluetoothd[17481]: State changed
> /org/bluez/17481/hci0/dev_00_00_00_00_00_00:
> HEADSET_STATE_CONNECTING -> HEADSET_STATE_DISCONNECTED
> > bluetoothd[17481]: Unix client disconnected (fd=22)
> > bluetoothd[17481]: client_free(0xb8dfa648)
> >
> > The mac addresses have been changed to all zeros.
> >
> > Maybe this is a limitation of the hardware or the
> device driver?
> >
> > I have set the MaxConnected to greater than 1,
> actually 15.  Are there any other settings I should be
> aware of.
> 
> For hsp/hfp you need to set MaxConnected, but for a2dp it

I have changed the MaxConnected under [Headset] to 15, is this the same as hsp/hfp, or should I create a new section?

> is required to change the number of sources/sinks to do the same, both
> can be configured via audio.conf. Now about the address, it really
> seems that you are using 00:00:00:00:00:00 to connect which explain

I just changed these to all zeros for privacy, and actually I missed one :)  Realistically, I guess it doesn't matter for other to see the mac, I just saw other people blocking their's out, so I thought maybe there was some privacy/security concern.

> why you are getting the host is down error, you can either choose a
> valid address or a valid dbus object.

Thanks,
Mark



      
