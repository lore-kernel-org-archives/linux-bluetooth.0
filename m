Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
	 <fbf08281001111105pc2f0d3au61d0e205e1689ec2@mail.gmail.com>
	 <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
	 <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
Date: Thu, 21 Jan 2010 15:54:40 +0800
Message-ID: <ac8af0be1001202354i7f1a98dbw55c56fc65f878358@mail.gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
From: Zhao Forrest <forrest.zhao@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, ofono@ofono.org,
	zhenhua.zhang@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Your patch removes many DBus APIs provided by audio/gateway.c, which
was originally designed to provide a set of DBus functions/signals for
ease of application development. In other words, your patch is too
oFono-specific, and is not a general support for HFP HF unit role in
BlueZ IMO. The DBus interface provided by your patch is not easy to
develop the application because the application developer has to parse
the AT commands by himself. I know that oFono could parse AT commands.
But I don't think it a common case for other application developers.
Why not extend audio/gateway.c instead of removing its DBus APIs or
create a new file to support HFP for oFono in blueZ?

I think maybe Marcel would have more comments on this to give a clear direction.

Thanks,
Forrest

On Thu, Jan 21, 2010 at 3:58 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
>> New version of the patches. Known issues:
>> "'org.bluez.HandsfreeAgent.Release' part not implemented" and it's not
>> working with more than one bluetooth devices in some cases. Comments
>> are welcome.
>>
>
> Another new version of the patches. Now ofono query all bluetooth
> devices and searches for the ones with Gateway interface.
> Bluez has some fixes and now supports connection coming from the AG.
> The patches are using a per-device agent as described by the last
> version of Handsfree API.
>
> I did not implemented yet 'org.bluez.HandsfreeAgent.Release'.
>
> Comments are welcome. :)
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>
