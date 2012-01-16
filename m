Return-Path: <cyrus@holtmann.org>
Message-ID: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
Subject: bluez 4.97: build failure when used in C++ apps
From: Patrick Ohly <patrick.ohly@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Milan Crha <mcrha@redhat.com>, ying.an.deng@intel.com,
	ulf.hofemeier@intel.com, ning.w.wang@intel.com
Date: Mon, 16 Jan 2012 09:25:41 +0100
Content-Type: multipart/mixed; boundary="=-6boj0tJ+j9l94lrtwY/k"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-6boj0tJ+j9l94lrtwY/k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hello!

Bluez 4.97 has entered some distros recently (Fedora Core, MeeGo 1.2
update), which broke compilation of the C++ code in SyncEvolution
using /usr/lib/bluetooth.h.

The compiler error is:
/usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
...

The reason is that C++, in contrast to C, does not allow conversion of
void * to anything, and this code gets compiled as C++ when the app is
written in C++. The macro with the assignment itself is older, but only
recent Bluez starts to use it in inline functions, thus triggering the
problem.

Attached is a proposed solution. Note that I have only verified that it
now compiles in C and C++, I have not actually tested the resulting
Bluez, because compilation fails for me on Debian Testing for another
reason (libcheck.a linked into shared object, doesn't work because not
relocatable).

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


--=-6boj0tJ+j9l94lrtwY/k
Content-Disposition: attachment; filename="bluez-4.97-cplusplus.patch"
Content-Type: text/x-patch; name="bluez-4.97-cplusplus.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

*** bluez-4.97/lib/bluetooth.h.orig	2012-01-16 09:06:07.171931288 +0100
--- bluez-4.97/lib/bluetooth.h	2012-01-16 09:07:02.523930152 +0100
***************
*** 113,119 ****
  ({						\
  	struct __attribute__((packed)) {	\
  		typeof(*(ptr)) __v;		\
! 	} *__p = (void *) (ptr);		\
  	__p->__v;				\
  })
  
--- 113,119 ----
  ({						\
  	struct __attribute__((packed)) {	\
  		typeof(*(ptr)) __v;		\
! 	} *__p = (typeof(__p)) (ptr);		\
  	__p->__v;				\
  })
  
***************
*** 121,127 ****
  do {						\
  	struct __attribute__((packed)) {	\
  		typeof(*(ptr)) __v;		\
! 	} *__p = (void *) (ptr);		\
  	__p->__v = (val);			\
  } while(0)
  
--- 121,127 ----
  do {						\
  	struct __attribute__((packed)) {	\
  		typeof(*(ptr)) __v;		\
! 	} *__p = (typeof(__p)) (ptr);		\
  	__p->__v = (val);			\
  } while(0)
  

--=-6boj0tJ+j9l94lrtwY/k--

