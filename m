Return-Path: <cyrus@holtmann.org>
Message-ID: <4DEB4759.3070403@gmail.com>
Date: Sun, 05 Jun 2011 11:07:37 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
CC: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>, stable@kernel.org
Subject: magicmouse regression [was: Linux 2.6.39.1]
References: <201106032246.25979.edt@aei.ca>
In-Reply-To: <201106032246.25979.edt@aei.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ccing some people.

On 06/04/2011 04:46 AM, Ed Tomlinson wrote:
> On Thursday 02 June 2011 20:38:35 you wrote:
>> I'm announcing the release of the 2.6.39.1 kernel.
>>
>> All users of the 2.6.39 kernel series must upgrade.
>>
>> The updated 2.6.39.y git tree can be found at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.39.y.git
>> and can be browsed at the normal kernel.org git web browser:
>>          http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.39.y.git;a=summary
>>
>
> Greg,
>
> Just updated to 39.1 and it breaks my magicmouse
>
> [  107.360715] input: Apple Wireless Mouse as /devices/pci0000:00/0000:00:13.2/usb2/2-4/2-4.4/2-4.4:1.0/bluetooth/hci0/hci0:21/input8
> [  107.376797] magicmouse 0005:05AC:030D.0005: input,hidraw3: BLUETOOTH HID v0.84 Mouse [Apple Wireless Mouse] on 00:02:72:20:20:1D
> [  107.423387] magicmouse 0005:05AC:030D.0005: unable to request touch data (2)
> [  107.451216] magicmouse: probe of 0005:05AC:030D.0005 failed with error 2
>
> and the magicmouse is dead.
>
> reverting 23746a66d7d9e73402c68ef00d708796b97ebd72
>
> makes it work as before.


-- 
js
