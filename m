Return-Path: <cyrus@holtmann.org>
Message-ID: <4A8BF5AB.2040206@inbd.com.br>
Date: Wed, 19 Aug 2009 09:52:59 -0300
From: Andre Thiago Souza <andre.souza@inbd.com.br>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Cross compile bluez 4.47
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, i'm trying to cross compile the bluez 4.47 on ARM platform and i 
have some problems.
To configure i set the following comand and all works fine:
$ ./configure --prefix=/usr/bt/ --host=arm-linux CC=arm-linux-gcc 
CPP=arm-linux-cpp AR=arm-linux-ar STRIP=arm-linux-strip 
RANLIB=arm-linux-ranlib LD=arm-linux-ld


But when i try to make the library:
$ make && make install

i got the following error:

make[2]: Entering directory `/usr/bluez-4.47/common'
  CCLD   test_textfile
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x44): 
In function `__libc_csu_init':
: undefined reference to `__init_array_end'
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x48): 
In function `__libc_csu_init':
: undefined reference to `__init_array_start'
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x8c): 
In function `__libc_csu_fini':
: undefined reference to `__fini_array_end'
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x90): 
In function `__libc_csu_fini':
: undefined reference to `__fini_array_start'
collect2: ld returned 1 exit status
make[2]: *** [test_textfile] Error 1
make[2]: Leaving directory `/usr/bluez-4.47/common'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/bluez-4.47'
make: *** [all] Error 2
