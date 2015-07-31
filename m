Return-Path: <cyrus@holtmann.org>
From: Adam Moore <adam.moore@savantsystems.com>
To: "Othman, Ossama" <ossama.othman@intel.com>,
	Adam Moore <adam.moore@savantsystems.com>
CC: Nathaniel McCallum <npmccallum@redhat.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT service DBus interface violates DBus spec
Date: Fri, 31 Jul 2015 18:00:24 +0000
Message-ID: <D1E10436.AD77%adam.moore@savant.com>
References: <1436456267.26457.24.camel@redhat.com>
 <1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
 <D1E0FD51.AD61%adam.moore@savant.com>
 <CAPyD+=BTGLzEKanLSS7kV8bz7mr7BL5ed0GHuXEKxCJYuTpPVg@mail.gmail.com>
In-Reply-To: <CAPyD+=BTGLzEKanLSS7kV8bz7mr7BL5ed0GHuXEKxCJYuTpPVg@mail.gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ossama, thanks for sharing - I didn¹t have the heart to go down that path
:)  Nice to have that solution available too.

Just a thought - since the Characteristic objects must provide their
service path via DBus Property, forcing their paths to be children of the
service path may be redundant, unless some logic is planned to be based on
the structure of the OM tree in the future.

On 7/31/15, 10:47 AM, "Othman, Ossama" <ossama.othman@intel.com> wrote:

>On Fri, Jul 31, 2015 at 10:30 AM, Adam Moore
><adam.moore@savantsystems.com> wrote:
>> I ran into this as well when trying to build a an external service with
>> GLibžs GDBusObjectManagerServer.  As I was highly motivated not to
>>rewrite
>> what I had, I have a little patch that relaxes the unwritten
>>expectation,
>> but it comes at the expense of being unable to enforce that
>> characteristics reside under the service object.  (I think the proxy
>> callback orderings are not guaranteed)  However, it does allow the
>>service
>> and characteristics to reside anywhere in the ObjectManager hierarchy.
>>
>> Ižll pass it along in case it helps accelerate a real fix, and perhaps
>>it
>> can unblock someone in the meantime.
>
>I ran into a similar problem with GLib, and ended up reluctantly
>replacing my use of GDBusObjectManagerServer with a hand-coded
>implementation (except for the signals) of the ObjectManager interface
>that was exported on the same object path as the
>org.bluez.GattService1 skeleton via
>g_dbus_interface_skeleton_export():
>https://git.iotivity.org/cgit/iotivity/tree/resource/csdk/connectivity/src
>/bt_le_adapter/linux/service.c#n213
>
>-Ossama


Statement of Confidentiality

The contents of this e-mail message and any attachments are confidential and are intended solely for the addressee. The information may also be legally privileged. This transmission is sent in trust, and the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or at 508.683.2500 and delete this message and its attachments, if any.

