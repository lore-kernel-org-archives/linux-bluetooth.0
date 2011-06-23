Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTik9GX_KOubOiStpjpYMBXQzEFOh+g@mail.gmail.com>
References: <BANLkTimaJSHEx0GoR1659tOWnYRBWV9Z0Q@mail.gmail.com>
	<BANLkTik9GX_KOubOiStpjpYMBXQzEFOh+g@mail.gmail.com>
Date: Thu, 23 Jun 2011 11:36:36 -0500
Message-ID: <BANLkTi=W1LxcfNM=b8z-Lw5_YDOBvaswiQ@mail.gmail.com>
Subject: Re: audio/manager.c:hf_io_cb() Refusing new connection since one
 already exists
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 22, 2011 at 2:17 PM, Mike <puffy.taco@gmail.com> wrote:
> On Mon, May 23, 2011 at 4:45 PM, Mike <puffy.taco@gmail.com> wrote:
>> I am having a problem where I can not connect my phone using HFP after
>> it has been once disconnected from bluetoothd.
>>
>
> I'm still having this problem (just tested on bluez 4.94).  I can
> disconnect my phone and execute the GetProperties method on
> org.bluez.HandsfreeGateway and the return State is connected.  If I
> execute the Disconnect method over DBus (org.bluez.HandsfreeGateway),
> the state of the connection is set properly to disconnected.  After
> doing this, I can reconnect my phone without error (of course it will
> fail again if I disconnect/reconnect).
>
> The one thing that has me curious is the lack of a call to
> "g_io_add_watch" for the hands free rfcomm.  It looks like most other
> io connections use this to detect the channel closing (e.g. the sco
> channel or the ag_confirm code).  Is this an oversight?
>
> Mike
>

OK, I get the feeling that the Bluez code is correct, but that the
agent (in this case ofono) is supposed to call the Disconnect method.
Can anyone confirm that this is the intention?  If so, I will take my
problems to the ofono mailing list :)
