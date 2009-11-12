Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <697456.15025.qm@web111405.mail.gq1.yahoo.com>
References: <2d5a2c100911120508y38dc967aga78c500e20c075d7@mail.gmail.com>
	 <697456.15025.qm@web111405.mail.gq1.yahoo.com>
Date: Thu, 12 Nov 2009 10:29:30 -0300
Message-ID: <2d5a2c100911120529s392e818bk281d09fdee77fa13@mail.gmail.com>
Subject: Re: Simultaneous outgoing audio streams
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Stanovich <stanmj@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 12, 2009 at 10:20 AM, Mark Stanovich <stanmj@yahoo.com> wrote:
>> For hsp/hfp you need to set MaxConnected, but for a2dp it
>
> I have changed the MaxConnected under [Headset] to 15, is this the same as hsp/hfp, or should I create a new section?
>
>> is required to change the number of sources/sinks to do the same, both
>> can be configured via audio.conf. Now about the address, it really
>> seems that you are using 00:00:00:00:00:00 to connect which explain
>
> I just changed these to all zeros for privacy, and actually I missed one :)  Realistically, I guess it doesn't matter for other to see the mac, I just saw other people blocking their's out, so I thought maybe there was some privacy/security concern.
>
>> why you are getting the host is down error, you can either choose a
>> valid address or a valid dbus object.

Sorry I just interpret this all wrong, as the application has been
sending 00:00:00:00:00:00, but yeah you seem to be doing it right
although Im not sure you can have more than one SCO connection active,
but that doesn't explain the host is down error, so perhaps there is
something else blocking you.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
