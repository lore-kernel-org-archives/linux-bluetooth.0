Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Jul 2015 13:18:58 -0400 (EDT)
From: Nathaniel McCallum <npmccallum@redhat.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
In-Reply-To: <1436456267.26457.24.camel@redhat.com>
References: <1436456267.26457.24.camel@redhat.com>
Subject: Re: GATT service DBus interface violates DBus spec
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So it appears that our initial analysis was incorrect. In fact, all the dbus libraries behave the same. However, the Bluez GATT interface (and perhaps others) expects ObjectManager to behave incorrectly. Similarly, the Bluez test code contains a bug in its ObjectManager implementation. The offending line is here: http://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server#n91

ObjectManager. GetManagedObjects() MUST NOT return itself in the set of returned children. The GATT interface needs to be updated to match this expectation.

----- Original Message -----
> The GATT service DBus interface currently requires that services
> implement the following interfaces:
> - org.freedesktop.DBus.ObjectManager
> - org.freedesktop.DBus.Properties
> - org.bluez.GattService1
> 
> An unwritten expectation is that the ObjectManager's GetManagedObjects
> method should include the object itself in its return value. However,
> the spec for GetManagedObjects states otherwise.
> 
> This currently works only because gdbus violates the spec.[1] Until
> today, systemd's sd-bus library was compliant with the spec and thus
> behaved differently from gdbus, making it impossible to use sd-bus with
> bluez.[2]
> 
> I agree with Lennart's proposal that the best course of action is to
> fix the spec, not the implementations. This would mean that no change
> is needed for bluez (other than perhaps some documentation). However, I
> wanted to raise awareness of this problem in case:
> 1. there is strong opposition to this proposal
> 2. others run into the same problem I did
> 
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=91283
> [2] https://github.com/systemd/systemd/commit/92d16a53e385781a55d9231d9
> f8f89c1747ab0e4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
