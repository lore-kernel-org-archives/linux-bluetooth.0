Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=W1LxcfNM=b8z-Lw5_YDOBvaswiQ@mail.gmail.com>
References: <BANLkTimaJSHEx0GoR1659tOWnYRBWV9Z0Q@mail.gmail.com>
	<BANLkTik9GX_KOubOiStpjpYMBXQzEFOh+g@mail.gmail.com>
	<BANLkTi=W1LxcfNM=b8z-Lw5_YDOBvaswiQ@mail.gmail.com>
Date: Thu, 23 Jun 2011 12:33:02 -0500
Message-ID: <BANLkTimWzPBsZ2L1rtuQ4yWR7qp3vgsy1A@mail.gmail.com>
Subject: Re: audio/manager.c:hf_io_cb() Refusing new connection since one
 already exists
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 23, 2011 at 11:36 AM, Mike <puffy.taco@gmail.com> wrote:
> On Wed, Jun 22, 2011 at 2:17 PM, Mike <puffy.taco@gmail.com> wrote:
>> On Mon, May 23, 2011 at 4:45 PM, Mike <puffy.taco@gmail.com> wrote:
>>> I am having a problem where I can not connect my phone using HFP after
>>> it has been once disconnected from bluetoothd.
>>>
>>
>> I'm still having this problem (just tested on bluez 4.94).  I can
>> disconnect my phone and execute the GetProperties method on
>> org.bluez.HandsfreeGateway and the return State is connected.  If I
>> execute the Disconnect method over DBus (org.bluez.HandsfreeGateway),
>> the state of the connection is set properly to disconnected.  After
>> doing this, I can reconnect my phone without error (of course it will
>> fail again if I disconnect/reconnect).
>>
>> The one thing that has me curious is the lack of a call to
>> "g_io_add_watch" for the hands free rfcomm.  It looks like most other
>> io connections use this to detect the channel closing (e.g. the sco
>> channel or the ag_confirm code).  Is this an oversight?
>>
>> Mike
>>
>
> OK, I get the feeling that the Bluez code is correct, but that the
> agent (in this case ofono) is supposed to call the Disconnect method.
> Can anyone confirm that this is the intention?  If so, I will take my
> problems to the ofono mailing list :)
>

OK, a little surprised that all I hear are crickets.  In any case, I
hacked together a fix for ofono that calls the Disconnect method when
ofono determines that the connection is disconnected.  But I'm not
entirely sure that that is the right solution.  The documentation of
org.bluez.HandsfreeAgent does not call out such a requirement, so it
leaves me to believe that bluez should already handle this on its own.
 Mainly bluez just needs to call "change_state(device,
GATEWAY_STATE_DISCONNECTED);" somehow so that connections will be
accepted again.  I appear to have working code, so it doesn't matter
to me if this discussion hits a dead-end, but I'm not about to submit
a patch unless it's confirmed which app is at fault (bluez or ofono).

Mike
