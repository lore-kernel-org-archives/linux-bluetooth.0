Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 14 Jul 2011 15:55:00 -0700
Message-ID: <CAH9SEo76kfgbvPbzw2jgCf1rvhQ4VRz0EDGiGg99HyUFq53t5Q@mail.gmail.com>
Subject: g++ 4.6 complains about code in bluez/lib/bluetooth.h
From: =?UTF-8?B?RG91ZyBLd2FuICjpl5zmjK/lvrcp?= <dougkwan@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  I have a project with C++ code that includes the header
bluez/lib/bluetooth.  g++-4.6 complains about some code in the header:

#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
#define BDADDR_ALL   (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}})
#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})

frameworks/base/core/jni/android_bluetooth_BluetoothAudioGateway.cpp:
In function 'int android::setup_listening_socket(int, int)':
frameworks/base/core/jni/android_bluetooth_BluetoothAudioGateway.cpp:494:30:
error: taking address of temporary [-fpermissive]
make: *** [out/target/product/stingray/obj/SHARED_LIBRARIES/libandroid_runtime_intermediates/android_bluetooth_BluetoothAudioGateway.o]
Error 1

The code in question was:

   memcpy(&laddr.rc_bdaddr, BDADDR_ANY, sizeof(bdaddr_t));

The macros above expand into expressions taking addresses of temporary
object.  My copy of draft C++ standards says:

5.3.1 Unary operators

The result of the unary & operator is a pointer to its operand. The
operand shall be an lvalue or a qualiﬁed-id. In the ﬁrst
case, if the type of the expression is “T,” the type of the result is
“pointer to T.” In particular, the address of an object of
type “cv T” is “pointer to cv T,” with the same cv-qualiﬁers. For a
qualiﬁed-id, if the member is a static member of type
“T”, the type of the result is plain “pointer to T.” If the member is
a non-static member of class C of type T, the type of
the result is “pointer to member of class C of type T.”

(bdaddr_t) {{0, 0, 0, 0, 0, 0}} is neither an lvalue nor a qualified-id.

Is this problem in bluetooth.h a known issue?

I would like to fix this.  I can see different ways of fixing it.
Instead of temporary objects,  globals variables can be used for the
special value.  There is a risk that code may modified the globals.
That would lead to hard to find bugs. Alternatively, we can define
macros like:

#define BDADDR_ANY_INITIALIZER   {{0, 0, 0, 0, 0, 0}}
#define BDADDR_ALL _INITIALIZER  {{0xff, 0xff, 0xff, 0xff, 0xff, 0xff}}
#define BDADDR_LOCAL_INITIALIZER {{0, 0, 0, 0xff, 0xff, 0xff}}

#define BDADDR_ANY   (&(bdaddr_t) BDADDR_ANY_INITIALIZER)
#define BDADDR_ALL   (&(bdaddr_t) BDADDR_ALL_INITIALIZER)
#define BDADDR_LOCAL   (&(bdaddr_t) BDADDR_LOCAL_INITIALIZER)

This preserves the old interface.  Standard conforming C++ code can do
something like

  bdaddr_t any = BDADDR_ANY_INITIALIZER;

  ... &any

Comments?
