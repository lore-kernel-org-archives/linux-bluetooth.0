Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306421410.2669.0.camel@novo.hadess.net>
References: <1306419070.2010.244.camel@novo.hadess.net>
	<1306421410.2669.0.camel@novo.hadess.net>
Date: Thu, 26 May 2011 19:00:37 +0300
Message-ID: <BANLkTikvWsxgN2C7yFyr8z3bmwvD9-h=1g@mail.gmail.com>
Subject: Re: Another pass at adapter naming
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, May 26, 2011 at 5:50 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2011-05-26 at 15:11 +0100, Bastien Nocera wrote:
>> As discussed on IRC,
>>
>> inotify is now required, and we force hci0 (or the first device) to be
>> named after the pretty hostname.
>>
>> Note that the GATT call isn't removed, it's now done in
>> adapter_update_local_name().
>
> As discussed again, removed the default adapter special casing, and
> we'll just call hci0 with the pretty name.

Does this means that the user cannot change permanently its adapter
name when pretty hostname is available? In that case I would suggest
having the stored name before pretty name otherwise if bluetoothd is
restarted the adapter name will be reset to pretty hostname again.


-- 
Luiz Augusto von Dentz
Computer Engineer
