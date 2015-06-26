Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com>
References: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>
	<20150625111827.6196924d@tedd-fedora-vm>
	<CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com>
Date: Fri, 26 Jun 2015 14:13:40 +0300
Message-ID: <CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
Subject: Re: Unreliable LE advertisement registration through BlueZ
 advertising API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Othman, Ossama" <ossama.othman@intel.com>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ossama,

On Thu, Jun 25, 2015 at 10:58 PM, Othman, Ossama
<ossama.othman@intel.com> wrote:
> Hi Tedd,
>
> Thanks for the quick follow-up!
>
> On Thu, Jun 25, 2015 at 11:18 AM, Tedd Ho-Jeong An <tedd.an@intel.com> wrote:
>> I had exactly same problem on FC22 with latest kernel from bluetooth-next and tip from the Bluez.
>
> For reference, I'm running Kubuntu 15.04 with the 4.1 kernel
> (http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.1-unstable/)
> installed.
>
>> After updating the system to latest version (./sudo dnf update) then it started to work.
>> I think there is some issue on DBUS not the bluez.
>
> Are you referring to the example-advertisement issue I'm seeing?  I
> haven't been able to get it to run all at all, which is odd since
> example-gatt-server works without problem.  AFAICT, my GDBus based LE
> advertisement code is not running to D-Bus related issues since BlueZ
> is able to retrieve all of the advertisement properties.  I'll crank
> up gdb on bluetoothd to verify the advertisement properties.

Perhaps he is talking about missing policy, bluetooth.conf should
contain the following:

    <allow send_interface="org.bluez.GattCharacteristic1"/>
    <allow send_interface="org.bluez.GattDescriptor1"/>
    <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
    <allow send_interface="org.freedesktop.DBus.Properties"/>


If it doesn't please update it and reload D-Bus service.

>> Any way, once I run the example-advertisement script, I cannot run it again until I restart the bleutooth daemon.
>> This is known issue.
>
> Okay, I'll keep digging.

That is something in the kernel Im afraid, it doesn't seems to remove
the instances properly.

> Thanks again!
> -Ossama
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
