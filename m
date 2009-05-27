Return-Path: <cyrus@holtmann.org>
Message-ID: <4A1D213A.6080803@hartkopp.net>
Date: Wed, 27 May 2009 13:17:14 +0200
From: Oliver Hartkopp <oliver@hartkopp.net>
MIME-Version: 1.0
To: Dave Young <hidave.darkstar@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: possible recursive locking in 2.6.30-rc6
References: <4A1A9D1D.2050301@hartkopp.net> <4A1AF7B0.4020701@hartkopp.net>	 <4A1BA619.4040401@hartkopp.net>	 <a8e1da0905261813i3577af33g101336259a51c03c@mail.gmail.com>	 <1243410155.20399.27.camel@localhost.localdomain> <a8e1da0905270411p44f5aac2l572bd744f20244ca@mail.gmail.com>
In-Reply-To: <a8e1da0905270411p44f5aac2l572bd744f20244ca@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Dave Young wrote:
> On Wed, May 27, 2009 at 3:42 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Dave,
>>
>>> Could you try the attached patch and report your result?
>> please create patches with git-format-patch, because otherwise I have to
>> do extra work to apply them.
>>
> 
> Sorry about the inconvenience, actually I created the patch by quilt.

Hi Dave,

Marcel already created a patch and asked David Miller to pull the fix:

http://marc.info/?l=linux-netdev&m=124341070008320&w=2

Thanks anyway!

Best regards,
Oliver
