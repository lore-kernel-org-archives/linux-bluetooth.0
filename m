Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333461650.1870.289.camel@aeonflux>
References: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
	<1333460117.1870.287.camel@aeonflux>
	<CACj007nj+fpeHV=KPsp2D-G_z=ixJuK-+5=XxNuR-x0Y5auRmw@mail.gmail.com>
	<1333461650.1870.289.camel@aeonflux>
Date: Wed, 4 Apr 2012 17:54:18 +0530
Message-ID: <CACj007ncL89Uf_mJWxFcq39R6fcTgjEPqUU=pDS-9p5r0ESK+Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Fix packet type for ESCO Link
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Naresh Gupta <naresh.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 3, 2012 at 7:30 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hemant,
>
>> >> This patch fixes the packet type for ESCO Link which was incorrectly
>> >> set for EDR ESCO Packet Types. Anding esco_type with ~EDR_ESCO_MASK
>> >> results in loosing information of esco packet type (EDR Packet
>> >> types are inverted as per BT Spec) that resulted in wrong calculation
>> >> of packet type in hci_setup_sync() API causing the HCI Setup Synchronous
>> >> Connection Command to fail.
>> >
>> > any chance you can add a hcidump trace to the commit message to show
>> > this failure?
>> >
>> I am attaching the hcicump Logs, that can be viewed in Capture File
>> Viewer of FTS.
>> In that the problem can be seen in HCI Tab, Frame # 619, where the
>> packet type is
>> incorrect resulting in command failure with error code 0x1a.
>
> so me installing a Windows to just view the logs is not going to
> happen ;)
>
> Since you run BlueZ on one side, please just create a hcidump trace. If
> you store them in BTSnoop format, you can open it with FTS as well.
>
I have uploaded another patch, please have a look. I found some issues in my
fix yesterday, so I have updated the patch with proper commit message.

> Regards
>
> Marcel
>
>



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
