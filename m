Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D1E11ED1.AD8E%adam.moore@savant.com>
References: <1436456267.26457.24.camel@redhat.com>
	<1539455180.3160545.1438363138455.JavaMail.zimbra@redhat.com>
	<D1E0FD51.AD61%adam.moore@savant.com>
	<CAPyD+=BTGLzEKanLSS7kV8bz7mr7BL5ed0GHuXEKxCJYuTpPVg@mail.gmail.com>
	<D1E10436.AD77%adam.moore@savant.com>
	<CAPyD+=DRdXnT_PBvd6C-KKTB3qmak5hmg97auubhc+x0CNzz_g@mail.gmail.com>
	<D1E11ED1.AD8E%adam.moore@savant.com>
Date: Sun, 2 Aug 2015 11:57:25 +0300
Message-ID: <CABBYNZ+5hWF42bNYh-zpqNXKu1Wi2PZQJ_i9634umgD-TMFtNw@mail.gmail.com>
Subject: Re: GATT service DBus interface violates DBus spec
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Adam Moore <adam.moore@savantsystems.com>
Cc: "Othman, Ossama" <ossama.othman@intel.com>,
	Nathaniel McCallum <npmccallum@redhat.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 31, 2015 at 10:50 PM, Adam Moore
<adam.moore@savantsystems.com> wrote:
>
>
> On 7/31/15, 12:45 PM, "Othman, Ossama" <ossama.othman@intel.com> wrote:
>
>>Hi Adam,
>>
>>On Fri, Jul 31, 2015 at 11:00 AM, Adam Moore
>><adam.moore@savantsystems.com> wrote:
>>> Ossama, thanks for sharing - I didn¹t have the heart to go down that
>>>path
>>> :)  Nice to have that solution available too.
>>
>>Ha!  Believe you me, I preferred not going down this path since it
>>basically reinvents the wheel. but I didn't have much choice at the
>>time since I needed to get something out the door that didn't rely too
>>heavily on upstream patches being merged.
>>
>>> Just a thought - since the Characteristic objects must provide their
>>> service path via DBus Property, forcing their paths to be children of
>>>the
>>> service path may be redundant, unless some logic is planned to be based
>>>on
>>> the structure of the OM tree in the future.
>>
>>Agreed.  In this case, I just followed the convention found in the
>>example hierarchy described in the "GATT Manager Hierarchy" section in
>>the BlueZ doc/gatt-api.txt document, as well as the hierarchy found in
>>the BlueZ test/example-gatt-server Python code.  Going with this
>>hierarchy also mimics the GATT service hierarchy described in the
>>Bluetooth spec.
>
> Yeah, I used the same structure in my implementation - that was really
> more of a note for the maintainers that if we can live without a strict
> structure, it might simplify the final fix.
>
>>
>>Thanks!
>>-Ossama

It seems the issue was closed caused GDBus and other bindings follow
the D-Bus spec to the word, but how one would list interfaces in the
root '/'? So either '/' shall become special and no other interface
shall be registered there or the spec should be reworded to include
the initial path, but the former is probably not backward compatible
since afaik most bindings allow custom interfaces in '/' path.


-- 
Luiz Augusto von Dentz
