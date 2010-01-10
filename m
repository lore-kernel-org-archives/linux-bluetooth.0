Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1001091515520.7275@pobox.suse.cz>
References: <1262544397.10071.60.camel@pldmachine>
	 <alpine.LNX.2.00.1001041224010.2277@pobox.suse.cz>
	 <1262619546.19140.1.camel@localhost.localdomain>
	 <1263046269.2938.6.camel@pldmachine>
	 <alpine.LNX.2.00.1001091515520.7275@pobox.suse.cz>
Date: Sun, 10 Jan 2010 10:35:21 -0800
Message-ID: <167e8a331001101035t8db59b3p809d3aa5e475273f@mail.gmail.com>
Subject: Re: [PATCH] Fix pad button definition in hid-wacom.c
From: Ping <pinglinux@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-2?Q?Przemys=B3aw_Firszt?= <przemo@firszt.eu>,
	Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>, Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2010/1/9 Jiri Kosina <jkosina@suse.cz>:
> On Sat, 9 Jan 2010, Przemys=C5=82aw Firszt wrote:
>
>> There is one more change required to get the pad buttons on wacom
>> bluetooth tablet fully working - see attached patch.
>
> Applied, thanks.
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

The patch below is needed for Wacom X.Org driver to receive the proper
PAD button events.  It is based on Przemo's applied patch attached to
this email sting.

Signed-off-by: Ping Cheng <pingc@wacom.com>

--- hid-wacom.c_old	2010-01-10 10:25:48.236272275 -0800
+++ hid-wacom.c	2010-01-10 10:25:45.216272921 -0800
@@ -197,6 +197,9 @@
 	/* Pad */
 	input->evbit[0] |=3D BIT(EV_MSC);
 	input->mscbit[0] |=3D BIT(MSC_SERIAL);
+	set_bit(BTN_0, input->keybit);
+	set_bit(BTN_1, input->keybit);
+	set_bit(BTN_TOOL_FINGER, input->keybit);

 	/* Distance, rubber and mouse */
 	input->absbit[0] |=3D BIT(ABS_DISTANCE);
