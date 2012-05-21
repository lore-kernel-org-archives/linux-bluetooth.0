Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+0+XrPcq9WGZpehOMLPZ_NBHaukpX3CWfQDkCunVdtVw@mail.gmail.com>
References: <CAKZqhqe-Go8T+LTvq48PL7FbLs8ffa7oySnC1Em7pK+nuoEQvw@mail.gmail.com>
	<CABBYNZ+0+XrPcq9WGZpehOMLPZ_NBHaukpX3CWfQDkCunVdtVw@mail.gmail.com>
Date: Mon, 21 May 2012 13:13:45 -0300
Message-ID: <CAM4ayVD5_GHr8PxE3E5dCNB9-+hHTSSh98rug-=YGmQ7+BLtjQ@mail.gmail.com>
Subject: Re: GSoC: OBEX Filesystem In Userspace
From: =?UTF-8?Q?Vin=C3=ADcius_Costa_Gomes?= <vcgomes@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: dmp <dmp0x7c5@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 21, 2012 at 9:44 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Michal,
>
> On Mon, May 21, 2012 at 2:54 PM, dmp <dmp0x7c5@gmail.com> wrote:
>> Hello BlueZ Community,
>>
>> GSoC coding period started today. Using this thread I will write about
>> project progress during summer.
>>
>> Initially prepared project repository could be found here:
>> https://github.com/dmp0x7c5/gobexfuse
>>
>> We decided to use "gobexfuse" as a project's name :)
>
> I thought this could be part of obexd repository, or this is just a
> clone? At least it doesn't look like a close which would mean you
> would have to copy gobex which IMO is a bad idea.

Makes sense, we can have this project inside obexd, and just enable it when
fuse is available in the system. And this makes it easier in case we need to
extend gobex.

>
> --
> Luiz Augusto von Dentz


Cheers,
-- 
Vinicius
