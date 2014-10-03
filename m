Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4r0Dx1b8vwWAwTWSNq+JD_1_622px4UG4FD1vsfS+BWiw@mail.gmail.com>
Date: Fri, 3 Oct 2014 11:55:43 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <35741970-1ED7-4A2B-8625-4F16186FA764@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com> <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com> <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com> <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org> <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com> <CAHF=Y4r0Dx1b8vwWAwTWSNq+JD_1_622px4UG4FD1vsfS+BWiw@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

> As you guys suggested, including ADV_IND in the Device Connected event
> made the trick (for which I just submitted a patch).
> 
> Everything goes well if I disconnect when rebonding (using Unpair
> Device with Disconnect=0x01).
> 
> However, I am struggling to go one step further and rebond without
> disconnecting (using Unpair Device with Disconnect=0x00) before the
> security elevation happens. The sequence of "events" is exactly as
> Johan described:
> 
>> 1. mgmt_ev_device_connected (connected_callback() in adapter.c)
>> 2. Connection indication on ATT server socket (src/attrib-server.c)
>> 3. device_attach_attrib() called (due to step 2)
>> 4. bt_io_set(io, ..., BT_IO_SEC_MEDIUM, ...);
> 
> Now I can detect the need to rebond in (1), which gives me control
> over the next steps. However, since rebonding is asynchronous, I don't
> know a simple way to ensure it is done before the security elevation
> happens. My ideas so far:
> 
> * Stall (3) through synchronization primitives until the rebonding is
> done, which sounds horrible.
> * Cancel (3) and somehow force an ATT reconnection (2) once the
> rebonding is done, which in turn would cause another security
> elevation, but I don't know how (I am probably making wrong
> assumptions about how the ATT socket works).

what sounds most simple to me is that we allow for a way to suspend and later resume the trigger for doing service discovery. Attaching the attribute channel is fine, but then essentially tell it to stay put.

This all becomes tricky and we might need to have some redesign and cleanups to do to make this work cleanly. We also long term want to switch to the newly designed gatt-client.c that we are working on. So something to keep in mind.

However one thing has to present and that is our GATT server. So even if we stall everything else and even if we drop the keys and unpair, the GATT server needs to be operational. So we need to attach the ATT protocol to the ATT socket that we are getting from the kernel on every single connection.

Regards

Marcel

