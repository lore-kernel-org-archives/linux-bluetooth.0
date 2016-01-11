Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: example-gatt-server question/clarification
Message-Id: <D8B1E315-F4CE-461E-B3A2-0A61ADB29599@gmail.com>
Date: Mon, 11 Jan 2016 10:38:41 -0800
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Having played with the example-gatt-server code, I have two basic questions that I need some help/clarification with:

1) I am writing a custom service with a single characteristic. Do *I* need to add any of my own descriptor stuff? Or is the basics handled by the library. The example is ambiguous because the interfaces to the stock attributes (e.g. heart rate, etc), do NOT add any descriptors. But the Test* variants, which are the only custom attributes in the example, does add a descriptor or two. So I’m left wondering is the purpose that these were added because A) you have to add descriptors for your own custom characteristics or B) because the example is demonstrating/testing additional things that you *could* do with additional descriptors.

2) In all WriteValue() implementations found in the code, a self.method() is never invoked. self.state might be adjusted/updated, but never is a method called. Is this just the way it turned out, or are there actual reasons not to do that? I’m finding that a pattern like:

    class MySubclass(Characteristic):

        def myOwnMethod(self):
            print(“Hello World”)

        def WriteValue(self, value):
            self.myOwnMethod()

seems to stop at the invocation of myOwnMethod. I don’t know if this is a dbus call back issue or something else.

TIA