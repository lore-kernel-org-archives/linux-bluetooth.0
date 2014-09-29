Return-Path: <cyrus@holtmann.org>
Date: Mon, 29 Sep 2014 17:35:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
Message-ID: <20140929143531.GA20265@t440s.P-661HNU-F1>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
 <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org>
 <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
 <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org>
 <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

On Mon, Sep 29, 2014, Alfonso Acosta wrote:
> * With 0x02, (HCI_AUTO_CONN_ALWAYS) there is auto-connection upon
> ADV_DIRECT_IND but replacing the device's batteries  (power-on
> ADV_IND) causes an infinite connection loop: connect->encryption
> on->disconnect(due to "encryption on" failing)->connect .... Getting
> the report data inside the  Device Connected event won't help because
> it will never get to that point.

Are you sure that you've mapped out the order of events correctly for
this case? The way things should be going (based on going through the
code - I haven't verified this in practice) on the user space side is:

1. mgmt_ev_device_connected (connected_callback() in adapter.c)
2. Connection indication on ATT server socket (src/attrib-server.c)
3. device_attach_attrib() called (due to step 2)
4. bt_io_set(io, ..., BT_IO_SEC_MEDIUM, ...);

The last step above is what instructs the kernel to initiate encryption.
If the mgmt_ev_device_connected would contain hints telling us to call
mgmt_unpair + mgmt_pair instead of trying to elevate security your use
case should be solvable.

If the above order is not what's happening we might be having a race
condition between the mgmt and ATT sockets. This race *should* be
fixable by ensuring that the mgmt socket has higher priority in the
mainloop than the ATT socket.  We used to have it like that in the past,
but we might have lost it along the way because shared/mgmt.c that uses
shared/io.h.

As a quick hack to check if these sockets are indeed racing against each
other during the same mainloop iteration you could try changing
G_PRIORITY_DEFAULT to G_PRIORITY_HIGH in the io_set_read_handler()
function in src/shared/io-glib.c (the ATT socket shouldn't be using that
but shared/mgmt.c is).

Johan
