Return-Path: <cyrus@holtmann.org>
Subject: Re: Urgent: Error in BlueZ-4.26 installation
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <Kartikey.Parmar@Matrixtelesol.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090112063804.7D94B8B547@mail.holtmann.org>
References: <20090112063804.7D94B8B547@mail.holtmann.org>
Content-Type: text/plain
Date: Sun, 18 Jan 2009 16:26:57 +0100
Message-Id: <1232292417.5095.24.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

>  I have downloaded the latest bluez stack release (bluez-4.26.tar.gz) from
> ur official website.
> 
> While configuring, it does not show any error but when I write command "Make
> && Make Install" it gives me below mentioned error and the compilation &
> installation procedure terminates here.
> 
> 
> ============================================================================
> =========================
> 
> gstrtpsbcpay.c: In Function 'gst_rtp_sbc_pay_flush_buffers'
> 
> gstrtpsbcpay.c:201: Warning: Implicit declaration of function
> 'get_adapter_copy'
> 
> gstrtpsbcpay.c: In Function 'gst_rtp_sbc_pay_class_init':
> 
> gstrtpsbcpay.c:288: error: 'GstBaseRTPPaylocalClass' has no member named
> 'handle_event'
> 
> make[3]: ***[libgstbluetooth_la_gstrtpsbcpay.lo] Error1
> 
> make[3]: Leaving directory 'bluez-4.26/audio'
> 
> make[2]: ***[all] Error2
> 
> make[2]: Leaving directory 'bluez-4.26/audio'
> 
> make[1]: ***[all_recursive] Error1
> 
> make[1]: Leaving directory 'bluez-4.26'
> 
> make: ***[all] Error2
> 
>  
> ============================================================================
> =========================
> 
> Kindly guide me through, wht steps I need to follow to resolve this error?
> 
> Pls reply me as early as possible so I can finish the installation and work
> on the latest bluez stack.

we have never seen these issue. Check with bluez-4.27 again and please
report your exact steps and environment details so we can reproduce it
if this persists.

Regards

Marcel


