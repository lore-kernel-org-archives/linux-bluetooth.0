Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <423983A5.6010207@amplex.dk>
From: Stephan Henningsen <sth@amplex.dk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Error compiling bluez-utils for buildroot/ARM
References: <4239536C.5030202@amplex.dk> <1111058060.11792.63.camel@pegasus>
In-Reply-To: <1111058060.11792.63.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 17 Mar 2005 14:18:29 +0100

Ok, I've discovered some weird things, one of them may very well be 
a bug in the build scripts of bluez-libs which isn't normally unless 
compiling for another target.

Any help clairfying these errors would be of great help:



Bluez-libs: --------------------------------------------------------

I cannot get bluez-libs installed where I want; The header files and 
the library files seem to install relative to different paths.

First of all, I configure bluez-libs like this (in my buildroot 
script, bluez-libs.mk):

$(BLUEZLIBS_DIR)/.configured: $(BLUEZLIBS_DIR)/.source
	(cd $(BLUEZLIBS_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--libexecdir=/usr/lib \
		--sysconfdir=/etc \
		--datadir=/usr/share \
		--localstatedir=/var \
		--mandir=/usr/man \
		--infodir=/usr/info \
	);
	touch $(BLUEZLIBS_DIR)/.configured;

Now I use two different install-targets to cover a complete 
installation:



First I have my install-target do this:

	$(MAKE) prefix=$(TARGET_DIR)/usr -C $(BLUEZLIBS_DIR) install

..which results in this error durring installation (line breaks in 
the e-mail make everything even more difficult, so I've added the 
'\' to join breaked lines):

/bin/sh ../libtool --mode=install /usr/bin/install -c \
			libbluetooth.la /usr/lib/libbluetooth.la
/usr/bin/install -c .libs/libbluetooth.so.1.0.15 \
			/usr/lib/libbluetooth.so.1.0.15
/usr/bin/install: cannot remove `/usr/lib/libbluetooth.so.1.0.15': \
			Permission denied

Seems to me like the library files ignore the DESTIDIR.  The header 
files, however, are installed properly under 
$(TARGET_DIR)/usr/include (bluetooth/bluetooth.h and friends).



Now I change my install-target to do this (added DESTDIR):

	$(MAKE) DESTDIR=$(TARGET_DIR) prefix=$(TARGET_DIR)/usr \
		-C $(BLUEZLIBS_DIR) install

..which installs incorrectly but without any error messages.  The 
library files are installed $(TARGET_DIR)/usr/lib BUT the header 
files are installed under 
$(TARGET_DIR)/home/sth/au/buildroot/build_arm/root/usr/include
where $(TARGET_DIR) is in fact /home/sth/au/buildroot/build_arm/root.

So two different prefixes are in use (with my current and possibly 
wrong configuration).



Anyway!  Though errors occured and files are dublicated and 
misplaced, at least now bluez-libs is installed completely on the 
target system! ;)  This brings me to my second problem with bluez-utils.



Bluez-utils: -------------------------------------------------------


This is weird:  I can build the bluez-utils manually, i.e. without 
the help of buildroot's scripts but with the help of its toolchain), 
but still not the right way (with buildroot's script).

For building bluez-tools manually I do this:


sth@speedball:~/au/buildroot$ make bluez-utils-dirclean
sth@speedball:~/au/buildroot$ make bluez-utils-source
sth@speedball:~/au/buildroot$ cd build_arm/
sth@speedball:~/au/buildroot/build_arm$ tar zxfv \
	../dl/bluez-utils-2.15.tar.gz
sth@speedball:~/au/buildroot/build_arm$ cd bluez-utils-2.15/
sth@speedball:~/au/buildroot/build_arm/bluez-utils-2.15$ export \
	PATH=/home/sth/au/buildroot/build_arm/staging_dir/bin/:$PATH
sth@speedball:~/au/buildroot/build_arm/bluez-utils-2.15$ \
	LDFLAGS="-L/home/sth/au/buildroot/build_arm/root/" \
	./configure --host=arm-linux-uclibc \
	--build=i686-pc-linux-gnu \
	--prefix="/home/sth/au/buildroot/build_arm/root/usr"


This builds bluez-libs successfully!

But doing it the buildroot-way like this, fails:


The configure target:

	(cd $(BLUEZUTILS_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		LDFLAGS="-L$(TARGET_DIR)/usr/lib" \
		CFLAGS="$(TARGET_CFLAGS)" \
		CPPFLAGS="-I$(TARGET_DIR)/usr/include" \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sbindir=/usr/sbin \
		--libexecdir=/usr/lib \
		--libdir=$(TARGET_DIR)/usr/include \
		--includedir=$(TARGET_DIR)/usr/include \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--infodir=/usr/info \
		--mandir=/usr/man \
		--with-bluez=/usr \
	);
	touch $(BLUEZUTILS_DIR)/.configured;

The compile target:

	$(MAKE) DESTDIR=$(TARGET_DIR) prefix=$(TARGET_DIR)/usr \
		-C $(BLUEZUTILS_DIR) install







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
