Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4239536C.5030202@amplex.dk>
From: Stephan Henningsen <sth@amplex.dk>
MIME-Version: 1.0
To: bluez-devel <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed;
 boundary="------------070000070806000809000809"
Subject: [Bluez-devel] Error compiling bluez-utils for buildroot/ARM
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Mar 2005 10:52:44 +0100

This is a multi-part message in MIME format.
--------------070000070806000809000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is not about a bug in bluez-utils, but I would like some help 
integrating BlueZ into the buildroot crossplatform environment.

I've made two packages (i.e. Config.in and .mk file) for the 
buildroot environment, that should support bluez-libs and 
bluez-utils.  The libs appear to install smoothly, but the utils 
fail during configure.

I've attached both the packages in a .tar.gz which can be extracted 
into buildroot/package/ where it will create both BlueZ packages. 
These packages basically delegate to the Makefile of BlueZ, so you 
guys should be home free ;)

The attached packages result in this error, when installing bluez-libs:

sth@speedball:~/au/buildroot$ make bluez-utils-dirclean bluez-utils
rm -rf /home/sth/au/buildroot/build_arm/bluez-utils-2.15
zcat /home/sth/au/buildroot/dl/bluez-utils-2.15.tar.gz | tar -C 
/home/sth/au/buildroot/build_arm -xf -
touch /home/sth/au/buildroot/build_arm/bluez-utils-2.15/.source
(cd /home/sth/au/buildroot/build_arm/bluez-utils-2.15; \
 
PATH=/home/sth/au/buildroot/build_arm/staging_dir/bin:/bin:/sbin:/usr/bin:/usr/sbin 
AR=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-ar 
AS=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-as 
LD=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-ld 
NM=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-nm 
CC=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc 
GCC=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc 
CXX=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-g++ 
RANLIB=/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-ranlib 
\
         CFLAGS="-Os -pipe " \
         ./configure \
         --target=arm-linux \
         --host=arm-linux \
         --build=i386-pc-linux-gnu \
         --prefix=/usr \
         --exec-prefix=/usr \
         --bindir=/usr/bin \
         --sbindir=/usr/sbin \
         --libexecdir=/usr/lib \
         --datadir=/usr/share \
         --sysconfdir=/etc \
         --localstatedir=/var \
         --infodir=/usr/info \
         --mandir=/usr/man \
         --with-bluez=/usr \
);
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... no
checking for mawk... mawk
...
...
...
checking bluetooth/bluetooth.h usability... yes
checking bluetooth/bluetooth.h presence... yes
checking for bluetooth/bluetooth.h... yes
checking for hci_open_dev in -lbluetooth... no
configure: error: Bluetooth library not found
make: *** 
[/home/sth/au/buildroot/build_arm/bluez-utils-2.15/.configured] Error 1
sth@speedball:~/au/buildroot$






If I add  --libdir=${TARGET_DIR}/usr/lib  (which expands to 
--libdir=/home/sth/au/buildroot/build_arm/root/usr/lib) to the 
configure command, the configuring succeeds, but compilation fails:

...

/home/sth/au/buildroot/build_arm/staging_dir/bin/arm-linux-uclibc-gcc 
-I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE  -Os -pipe    -o hcid 
main.o security.o storage.o lib.o parser.o lexer.o kword.o 
glib-ectomy.o     -L/home/sth/au/buildroot/build_arm/root/usr/lib 
-lbluetooth
lexer.o(.text+0x7e0): In function `yy_get_next_buffer':
: undefined reference to `_IO_getc'
collect2: ld returned 1 exit status
make[3]: *** [hcid] Error 1
make[3]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15/hcid'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15'
make[1]: *** [all] Error 2
make[1]: Leaving directory 
`/home/sth/au/buildroot/build_arm/bluez-utils-2.15'
make: *** 
[/home/sth/au/buildroot/build_arm/bluez-utils-2.15/src/l2ping.o] Error 2
sth@speedball:~/au/buildroot$


I am new to buildroot and not very experinced with compiler flags, 
especially not in a cross-compile environment.  For all I know, the 
extra --libdir may very well result in a hardcoded path, that 
doesn't resolve on the target system.


Any help is appreciated as I am stuck!


-- 
Stephan Henningsen

--------------070000070806000809000809
Content-Type: application/octet-stream;
 name="bluez-packages.tar.bz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bluez-packages.tar.bz"

H4sIAApTOUIAA+1aW2+bSBTOq/kVozQPRluDwZdIjvzgOG5q1bnIl11ttVKEYWyjEGABt012
97/vDNchHmwnTpxUPV9UGWbmzLnOMB90ai3xQ8Uyp7588FqoEhxXq/RXOW7kfhMcKFVVaar1
htI8PqgqaqPWPECNV7OIwdIPNA+hAz9YrB23qT9xJPn9STDN8t917Jk5l0z7pXXQeDTX5F+t
NqP8V9Ua+SP5r6sNkv+9BPEXz78eJh2dDtWb6073S+e8d3M6mPS+3gz6pyOhNHUcCx1mRXIo
lAw805ZWgO6F0gJbrlAqdZ0717QwChYYnZKhXxEVCBwnWCAi5GnePXI1/VabY0kg4xdB4LZk
OZxVcry5LLx1FH5dMOs/u5Tubl9Sx4b1X69VFWb/b5L131BqsP73gg+7QCB/KCsbVI6ul4Fp
+UjzMDJtpCEfu9jTApzsAaIUynUMAxtoeo9GAXYXmo0+Y9s27bmP7Y8o3iI0/9bSbMOQjFsq
s5Ot4bZGd7Wb33vDUf/qstVWJaXBtI+uJsNur9XOPKoclVfERIkUjDR/YAX7YyKW29Z8Z+np
eEZ2NyzZOJAN57ttOZrBSJ31h602UTDpD87ojShvUMzInvYvO8M/W23f0+V0s5UcZsS4Mzzv
jdOBS9+TycT0XzbedwThqHw2iLSzKqNQiC2hdFT+g8wjoso1Soei3FDiPFeYzp3zVpTjsLTQ
Wq1C6UHXgvVj0L+IrttKF7ERJDfE75ur6zGJ14gYLZQCZ6kvUJElPBujR+LSw0arWK5U1o2V
3hP0F3m8hTbQ2HevLj/1zyfDHjWIWEM7u58GnfNR+zAbFDaIh2GvJKfKw/tKhTg5xwEpk/PL
SZLTy85FT4z7F46/pne6NC0j7v58Ncp3uh6emT/aMimNuAX/wDqneWrahumFLTK5jlt9ttnP
2kmF0XnSLnKfSNz71L2wBwd63GpogZbNs9BS1y1H1yyyOwc47P6mJfbcaZlich23mvbMSZvp
DW0XT4orIMvzCacM2IZoEYm8csgmoUvlovOFhLfbbWfp7YpxkeYEqcJ4xIq23MrlKeWYlik/
643GZFQ7Nz+Kk5pXSjPMsY3s2iTqliUI2X7UQkud/OpoW7NZ4cp2q56VSMO6IeZ5mfAYumXA
WMnY4dbzvNMtrNmtLANPivXSTqJdqiQT8MaFSnJqSa0nmr07VPFmnCLb/ek+dlwLf8MWutBu
iVvklO+4genY/s7PY3OG/0blo7IfeKZLbedSEFH8eC8KUSRHvzGPZgGTTWAmAHXYDcyJ7dVe
AG3//qeh1Kv0/K8ew/uf/YDNP3P9ogxwE/9rKs00/7WaQvlfo1EH/rcP7P6EYDlfmSGD75L/
Tcb9AZcARh15Bhj6lDCxnGSeA8ayTyWBkVgRC1yjnBVniaCluiR+CQuM+jk0kBzV46Ec9sfG
YRP9y/zmi6en6tTTdQwwL1pAAXODnscBV43h2slhgRxJlgZm3cAD1/LAQsbHJ4iFPJDL+Ar5
4XczWFTCtZX6tMIO+QVwwiuQXMtjrsafZxuGmEkWUETOsubq5dknlMgaiQuvMjj6J5rlvyQ9
h2hnEpkZkLLID7tTU+6slPQMZ2hFjqY8IUrhJrqeu/LimRMvZq+PNjtWZpW/FpTEI6k8g92U
zpzwehK72c1n0FgmL+t5LDMwR2QjzYVMll0Mux9U3pLKhp5wuWwYgrcjs+z5/7U+AG/8/qvE
/K9aJ0SxTr//1ps1OP/vA4Xff8OKzX8ADqvkyV+AqZQZwBfg94li/i9NtRd6B7A9/6831WP6
/z+aNbUK638f2P2xCvwf+D/wf+D/7/o7MPD/kPB9eIsXAMD/gf8D/3+n/B8AAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAMDPj/8BMc4z4wBQAAA=
--------------070000070806000809000809--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
