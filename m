Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC15A27.90305@codeaurora.org>
Date: Mon, 14 Nov 2011 10:12:55 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Antonio Ospite <ospite@studenti.unina.it>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Building master on Debian systems fails at linking "check".
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
In-Reply-To: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

On 11/14/2011 6:56 AM, Antonio Ospite wrote:
> Hi,
>
> building the master branch (a267bc2) on Debian systems fails when
> linking the unit tests to the "check" library with this error:
>
>    CCLD   unit/test-eir
> /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/4.6/../../../../lib/libcheck.a
> (check.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be
> used when making a shared object; recompile with
> -fPIC /usr/lib/gcc/x86_64-linux-gnu/4.6/../../../../lib/libcheck.a:
> could not read symbols: Bad value collect2: ld returned 1 exit status
> make[1]: *** [unit/test-eir] Error 1 make: *** [all] Error 2
>
> [...]

I run into the same problem with an ubuntu-10.10 installation running in 
a VM.

>
> The workaround I use for now is:
>    - run "make" and let the build system fail
>    - show the  failing command with "make V=1"
>    - change -lcheck to -lcheck_pic and rerun the command
>    - "make" will now proceed with the build


This same solution works for me:  After running ./bootstrap-configure, I 
change the unit_test_eir_LDADD line in the Makefile to:

unit_test_eir_LDADD = lib/libbluetooth-private.la -lglib-2.0   -lcheck_pic

There is probably a way to make this happen automatically, but I don't 
know enough about the configure mechanism to know how to do this.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
