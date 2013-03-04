Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: Re: rfcomm example setup
References: <87ip57une7.fsf@randy.site>
	<CABBYNZ+L8=8dweH02e4dwaUEfcY0FY_yF3dK1XjZd+X9FwGcYg@mail.gmail.com>
Date: Mon, 04 Mar 2013 15:30:35 -0500
In-Reply-To: <CABBYNZ+L8=8dweH02e4dwaUEfcY0FY_yF3dK1XjZd+X9FwGcYg@mail.gmail.com> (Luiz
	Augusto von Dentz's message of "Mon, 4 Mar 2013 22:25:12 +0200")
Message-ID: <8738waucus.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks!

--Randy

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> Hi Randy,
>
> On Mon, Mar 4, 2013 at 6:42 PM, Randy Yates <yates@digitalsignallabs.com> wrote:
>> Can someone please point me to an example of the bind, listen, and
>> accept structures and parameters for setting up an RFCOMM socket using
>> file descriptor (fd) received from the NewConnection() method in
>> profile-api.txt?
>>
>> I tried the setup in "Bluetooth Essentials for Programmers," omitting
>> the socket() call (since bluez provides the fd) but it's crashing right
>> at the bind() call (never reaches the "bt 0.1" fprintf()). See
>> attachment.
>
> You don't have to bind, the socket is already in connected state so
> you can already do read/write operations. Btw, don't forget to respond
> to NewConnection otherwise it will timeout and bluetoothd will
> probably disconnect the fd.

-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
