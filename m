Return-Path: <cyrus@holtmann.org>
From: Adam Moore <adam.moore@savantsystems.com>
To: Nathaniel McCallum <npmccallum@redhat.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT service DBus interface violates DBus spec
Date: Fri, 31 Jul 2015 17:30:44 +0000
Message-ID: <D1E0FD51.AD61%adam.moore@savant.com>
References: <1436456267.26457.24.camel@redhat.com>
 <1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
In-Reply-To: <1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I ran into this as well when trying to build a an external service with
GLib¹s GDBusObjectManagerServer.  As I was highly motivated not to rewrite
what I had, I have a little patch that relaxes the unwritten expectation,
but it comes at the expense of being unable to enforce that
characteristics reside under the service object.  (I think the proxy
callback orderings are not guaranteed)  However, it does allow the service
and characteristics to reside anywhere in the ObjectManager hierarchy.

I¹ll pass it along in case it helps accelerate a real fix, and perhaps it
can unblock someone in the meantime.

-Adam

On 7/31/15, 10:18 AM, "linux-bluetooth-owner@vger.kernel.org on behalf of
Nathaniel McCallum" <linux-bluetooth-owner@vger.kernel.org on behalf of
npmccallum@redhat.com> wrote:

>So it appears that our initial analysis was incorrect. In fact, all the
>dbus libraries behave the same. However, the Bluez GATT interface (and
>perhaps others) expects ObjectManager to behave incorrectly. Similarly,
>the Bluez test code contains a bug in its ObjectManager implementation.
>The offending line is here:
>http://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-serv
>er#n91
>
>ObjectManager. GetManagedObjects() MUST NOT return itself in the set of
>returned children. The GATT interface needs to be updated to match this
>expectation.
>
>----- Original Message -----
>> The GATT service DBus interface currently requires that services
>> implement the following interfaces:
>> - org.freedesktop.DBus.ObjectManager
>> - org.freedesktop.DBus.Properties
>> - org.bluez.GattService1
>>
>> An unwritten expectation is that the ObjectManager's GetManagedObjects
>> method should include the object itself in its return value. However,
>> the spec for GetManagedObjects states otherwise.
>>
>> This currently works only because gdbus violates the spec.[1] Until
>> today, systemd's sd-bus library was compliant with the spec and thus
>> behaved differently from gdbus, making it impossible to use sd-bus with
>> bluez.[2]
>>
>> I agree with Lennart's proposal that the best course of action is to
>> fix the spec, not the implementations. This would mean that no change
>> is needed for bluez (other than perhaps some documentation). However, I
>> wanted to raise awareness of this problem in case:
>> 1. there is strong opposition to this proposal
>> 2. others run into the same problem I did
>>
>> [1] https://bugs.freedesktop.org/show_bug.cgi?id=91283
>> [2] https://github.com/systemd/systemd/commit/92d16a53e385781a55d9231d9
>> f8f89c1747ab0e4
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>>linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-bluetooth" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


Statement of Confidentiality

The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.

