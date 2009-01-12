Return-Path: <cyrus@holtmann.org>
From: "Kartikey Parmar" <Kartikey.Parmar@Matrixtelesol.com>
To: <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>
Cc: <kartikey.parmar@matrixtelesol.com>
Subject: Urgent: Error in BlueZ-4.26 installation
Date: Mon, 12 Jan 2009 12:08:33 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20090112063804.7D94B8B547@mail.holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Dear Sir / Madam

 I have downloaded the latest bluez stack release (bluez-4.26.tar.gz) from
ur official website.

While configuring, it does not show any error but when I write command "Make
&& Make Install" it gives me below mentioned error and the compilation &
installation procedure terminates here.


============================================================================
=========================

gstrtpsbcpay.c: In Function 'gst_rtp_sbc_pay_flush_buffers'

gstrtpsbcpay.c:201: Warning: Implicit declaration of function
'get_adapter_copy'

gstrtpsbcpay.c: In Function 'gst_rtp_sbc_pay_class_init':

gstrtpsbcpay.c:288: error: 'GstBaseRTPPaylocalClass' has no member named
'handle_event'

make[3]: ***[libgstbluetooth_la_gstrtpsbcpay.lo] Error1

make[3]: Leaving directory 'bluez-4.26/audio'

make[2]: ***[all] Error2

make[2]: Leaving directory 'bluez-4.26/audio'

make[1]: ***[all_recursive] Error1

make[1]: Leaving directory 'bluez-4.26'

make: ***[all] Error2

 
============================================================================
=========================

Kindly guide me through, wht steps I need to follow to resolve this error?

Pls reply me as early as possible so I can finish the installation and work
on the latest bluez stack.

Awaiting for reply.

Regards,
Kartikey Parmar
R&D Software Engineer
Matrix Telecom Pvt Ltd
Baroda - 390010 (Gujarat) India
(0) +91-265-2630555 Ext: 340
