Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <558281D4.4080304@ubnt.com>
References: <CANzaTi4s93PcjitnF-HWEo02SkYj+Z8rY5uNb9cjiySVnE1MiQ@mail.gmail.com>
	<558281D4.4080304@ubnt.com>
Date: Thu, 18 Jun 2015 11:02:43 +0200
Message-ID: <CANzaTi6FBqUARP7iqSMfYMJmE6L-6cp2DKAzrMBzn948+dSs4w@mail.gmail.com>
Subject: Re: Detect client connection using dbus api
From: dogan yazar <doganyazar@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the answer. How does it differentiate if it is a client or
a server? If bluez work as a client and connect to a device, same
property will be set anyway.

On Thu, Jun 18, 2015 at 10:31 AM, Andrejs Hanins
<andrejs.hanins@ubnt.com> wrote:
> Hi,
>
> On 06/18/2015 11:24 AM, dogan yazar wrote:
>> I use gatt-api to register my services but then could not find a way
>> to detect that a client is connected and discovering my services.
>> Any ideas?
> In case of connected client, there will be a org.bluez.Device1 object created
> with Connected propery set to "true". So if you would like to track connect/disconnect
> events, you should listed for this property changes. At least, this is how I do it.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
