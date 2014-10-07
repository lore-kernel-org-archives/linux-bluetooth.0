Return-Path: <cyrus@holtmann.org>
Message-ID: <54342942.5080202@opensource.dyc.edu>
Date: Tue, 07 Oct 2014 13:56:18 -0400
From: "Anthony G. Basile" <basile@opensource.dyc.edu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, blueness@gentoo.org,
	pacho@gentoo.org
Subject: Re: [PATCH] emulator/serial.c: use posix_openpt() instead of getpt()
References: <1412433102-12904-1-git-send-email-basile@opensource.dyc.edu> <20141007145621.GB10391@t440s.P-661HNU-F1>
In-Reply-To: <20141007145621.GB10391@t440s.P-661HNU-F1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/07/14 10:56, Johan Hedberg wrote:
> Hi Anthony,
>
> On Sat, Oct 04, 2014, basile@opensource.dyc.edu wrote:
>> From: "Anthony G. Basile" <basile@opensource.dyc.edu>
>>
>> getpt(3) is glibc-specific and is not provided in musl and possibly
>> other libc's. Instead, we use use posix_openpt(3) which is equivalent
>> and portable.
>>
>> Signed-off-by: Anthony G. Basile <basile@opensource.dyc.edu>
>> ---
>>   emulator/serial.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> Applied, thanks. I first had to remove the Signed-off-by line though
> since we don't don't use that convention for user space patches.
>
> Johan
>

That's fine.

-- 
Anthony G. Basile, Ph. D.
Chair of Information Technology
D'Youville College
Buffalo, NY 14201
(716) 829-8197
