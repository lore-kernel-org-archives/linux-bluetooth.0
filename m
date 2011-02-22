Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110222140512.GA12838@piper>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
	<1298367822-27766-5-git-send-email-luiz.dentz@gmail.com>
	<20110222140512.GA12838@piper>
Date: Tue, 22 Feb 2011 16:13:30 +0200
Message-ID: <AANLkTimBVmWt+=_+NXSfXzwUMPZRB8WjDOZr6RLXFa=G@mail.gmail.com>
Subject: Re: [PATCH 5/5] Fix --enable-usb build
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 22, 2011 at 4:05 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
> On 11:43 Tue 22 Feb, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
>>
>> ---
>>  configure.ac |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 602c948..fc63b8c 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -156,7 +156,7 @@ AC_ARG_ENABLE(usb, AC_HELP_STRING([--enable-usb],
>>       enable_usb=${enableval}
>>  ])
>>  AM_CONDITIONAL(USB, test "${enable_usb}" = "yes" &&
>> -                             test "${enable_server}" != "no")
>> +                             test "${enable_usb}" != "no")
>
> I failed to notice how the new line that you added is different from the
> first line of the AM_CONDITIONAL(). Perhaps just removing the "enable_server"
> test is enough. Or am I missing something?
>
>>
>>  AC_ARG_ENABLE(pcsuite, AC_HELP_STRING([--enable-pcsuite],
>>                               [enable Nokia PcSuite plugin]), [
>> --

Actually this is wrong, I though it was a type but it is not, but you
are right we should not need to check for server there as we do
already in Makefile.am.


-- 
Luiz Augusto von Dentz
Computer Engineer
