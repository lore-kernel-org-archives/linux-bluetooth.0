Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 1/3] various header include fixes for building with musl libc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_Mo=hGHMYFhurEO2+L_UPpT3YPy-is020d1_CMrXzDeRw@mail.gmail.com>
Date: Wed, 22 Jan 2014 08:03:49 -0800
Cc: Natanael Copa <natanael.copa@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Natanael Copa <ncopa@alpinelinux.org>
Message-Id: <9A9E726B-46AD-4AE6-82B7-77A50B5204AD@holtmann.org>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com> <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org> <1390398620-1916-2-git-send-email-ncopa@alpinelinux.org> <CAJdJm_Mo=hGHMYFhurEO2+L_UPpT3YPy-is020d1_CMrXzDeRw@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>> diff --git a/src/textfile.h b/src/textfile.h
>> index b779bd2..e26da5d 100644
>> --- a/src/textfile.h
>> +++ b/src/textfile.h
>> @@ -24,6 +24,8 @@
>> #ifndef __TEXTFILE_H
>> #define __TEXTFILE_H
>> 
>> +#include <sys/stat.h>
>> +
> 
> I believe the correct approach here is to include sys/stat.h on all
> files that include textfile.h. We (usually) don't #include system
> headers inside internal headers.

with code in src/shared/*.h we started to include the system headers that are required from the header, but you are correct, we don’t do that for internal src/*.h headers.

Also we do not use circular inclusion protection from internal headers. So I ripped the stupid __TEXTFILE_H stuff out now.

Regards

Marcel

