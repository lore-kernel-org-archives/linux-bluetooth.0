Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 10 Jan 2014 09:57:25 -0800
Message-ID: <CAOVeLGSGAf9LmsEcaAiECh+zL-7bg-gZJnue4TqzbBCNFfMj3w@mail.gmail.com>
Subject: Compilation using clang
From: Donald Carr <sirspudd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Top of the morning,

qtconnectivity currently contains a kludge which is required due to
the use of the GCC typeof extension in bluetooth.h which is breaking
with Clang compilation against the cxx11 spec.

The kludge in question involves molesting the standard (eg -std=cxx11)
specified to the compiler (explicitly away from cxx11 toward g++0x)
and hence I am hoping to be able to murder its intrusive self. I am
not entirely clear on the nuances though:

This is the offending section:

#define bt_get_unaligned(ptr)                   \
({                                              \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;         \
        } *__p = (typeof(__p)) (ptr);               \
        __p->__v;                               \
})

#define bt_put_unaligned(val, ptr)              \
do {                                            \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;         \
        } *__p = (typeof(__p)) (ptr);               \
        __p->__v = (val);                       \
} while(0)

and changing typeof to __typeof__ has been verified to succeed in the
stated circumstance. I don't know whether this is the ideal solution,
or whether decltype or so other designator would be a closer/better
match.

Any feedback would be greatly appreciated, I am using this change
locally and I think it could be of broader use to people.

Yours sincerely,
Donald Carr


-- 
-------------------------------
 °v°  Donald Carr
/(_)\ Vaguely Professional Penguin lover
 ^ ^

Cave canem, te necet lingendo
