Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1236523586.16880.141.camel@cookie.hadess.net>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
Date: Mon, 9 Mar 2009 10:08:11 -0300
Message-ID: <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
Subject: Re: Broken SDP parsing?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Mar 8, 2009 at 11:46 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2009-03-06 at 01:00 +0000, Bastien Nocera wrote:
>> Heya,
>>
> <snip>
>> The first 2 chars in the IEEE1284 ID are supposed to be the length of
>> the string. This should enable me to make the CUPS backend's discovery
>> work again.
>
> This isn't quite enough it seems.
>
> >From DiscoverDevices on org.bluez.Device:
>        <attribute id="0x0300">
>                <text value="" />
>        </attribute>
>
It may happen that bluetoothd and sdptool doesn't really share the sdp
xml parsing code. So perhaps we need to replicated your fix on
bluetoothd too or just make bluetoothd to use what you have done for
sdptool.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
