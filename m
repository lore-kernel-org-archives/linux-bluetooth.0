Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235571257.24169.19.camel@localhost.localdomain>
References: <c2a31c480902250519s1ea7a667k6f96b816730fc5cf@mail.gmail.com>
	 <1235571257.24169.19.camel@localhost.localdomain>
Date: Thu, 26 Feb 2009 17:59:22 +0530
Message-ID: <c2a31c480902260429h28579176sdf421f9feda2abc6@mail.gmail.com>
Subject: Re: API for Input Devices
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> =A0 I would like to know the entry points into BlueZ code to do the foll=
owing
>> a) Trigger BlueZ to send the Get_Report to HID Device.
>> b) Trigger BlueZ to send Reports to Device on Interupt Channel.
>
> that is the job of the HID subsystem in the Linux kernel. BlueZ is only
> providing the HIDP transport.
>
Are there any user mode libraries through which i can trigger the HID
Subsystem to Send Get_Report to a Device.
Any suggestions on which mailing list to post query will also be helpful.
Also wanted to know if HID Host is qualified on Linux with BlueZ?
Thanks & regards,
Sreevani M
