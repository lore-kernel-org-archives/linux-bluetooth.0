Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Async mismatch?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CFBCE3E1-9F51-4C87-A4BF-0D8B01C737B4@gmail.com>
Date: Mon, 28 Mar 2016 16:38:39 -0700
Message-Id: <5651FA03-C997-4DA3-B6F1-5AF85BCDC270@gmail.com>
References: <F0CC57E5-9193-483D-A2DF-33254216E6AD@gmail.com> <CFBCE3E1-9F51-4C87-A4BF-0D8B01C737B4@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As I try to “read the source” to figure out why my python dbus callbacks aren’t working as expected, I noted that the C source code refers to a GDBUS_EXPERIMENTAL_ASYNC_METHOD for the WriteValue method.

I also noticed when I looked at the documentation for the @dbus.service.method decorator, that one of the arguments is an async callback. It seemed odd to me that it wasn’t being set. Is this a funny coincidence, two different meanings of the async word, or would it explain why these two variants of a WriteValue behavior differently:

1)       def WriteValue(self, value):
                print(value)
                seq = bytes(0 + x for x in value)
                myOtherModule.myFunction(seq)
                print("dispatched”)

 only prints 

dbus.Array([dbus.Byte(1), dbus.Byte(2), dbus.Byte(3), dbus.Byte(4), dbus.Byte(5), dbus.Byte(6), dbus.Byte(7), dbus.Byte(8)], signature=dbus.Signature('y’))

But 2)  def WriteValue(self, value):
                print(value)
                seq = bytes(0 + x for x in value)
             #    myOtherModule.myFunction(seq) <<— COMMENTED OUT
                print("dispatched”)

now prints 

dbus.Array([dbus.Byte(1), dbus.Byte(2), dbus.Byte(3), dbus.Byte(4), dbus.Byte(5), dbus.Byte(6), dbus.Byte(7), dbus.Byte(8)], signature=dbus.Signature('y’))
dispatched

(it finished).

I wondered if it was a timeout thing, but it appears that the timeout is set at 300 seconds? Which seems really long, I note that dbus appears to have a default timeout if you just pass -1 here, why not use that?