Return-Path: <cyrus@holtmann.org>
Message-ID: <52FE19C4.1070702@convergeddevices.net>
Date: Fri, 14 Feb 2014 13:27:32 +0000
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: Help in getting BlueZ version - 5.14 running please
References: <52FD205F.7030704@convergeddevices.net> <CABBYNZKTveir=GZ0VjPt=WmpbDUCk9MzVH+R-5cvd=NGS7TxCQ@mail.gmail.com>
In-Reply-To: <CABBYNZKTveir=GZ0VjPt=WmpbDUCk9MzVH+R-5cvd=NGS7TxCQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you for the information.  Yes, my kernel is 3.2. I shall try blueZ 
4.101. Hopefully that wont have any dependency on the kernel version?

Thanks,
Tony

On 14/02/14 11:59, Luiz Augusto von Dentz wrote:
>
> On Feb 13, 2014 10:13 PM, "tony" <tony.makkiel@convergeddevices.net
> <mailto:tony.makkiel@convergeddevices.net>> wrote:
>  >
>  > Hi,
>  >         I am trying to familiarize with blueZ commands. I can scan
> devices and see HCI commands and events using hcidump. But am having
> some problems which I have been trying to figure out the past two days.
> Any suggestions or pointers will be much appreciated.
>  >
>  > 1) I found a lot of forums talking about creating connection. But
> couldn't find any which says how to accept connection. I am trying to
> accept an A2DP connection. The peer device is sending an AVDTP Connect
> request but don't know how to make blueZ respond. Can somebody please help?
>  >
>  > 2) I tried to start bluetooth daemon by running
>  >>
>  >> ../src/bluetoothd -n -d
>  >> bluetoothd[4440]: Bluetooth daemon 5.14
>  >> bluetoothd[4440]: Failed to access management interface
>  >> bluetoothd[4440]: Adapter handling initialization failed
>
> Looks like you don't have mgmt interface enabled in your kernel,
> probably because it is too old for using with BlueZ 5 which require at
> least 3.4 but nowadays it is probably recommended to use 3.10 or latter.
>
>  >
>  > The kernel modules I have are
>  >
>  >> lsmod | grep blue
>  >> bluetooth             158447  7 rfcomm,bnep,btusb
>  >
>  >
>  > Should I be running any other command before bluetoothd?
>  >
>  > 3) I am get problem in getting the python scripts in the test folder.
>  > For example when I try to run simple-agent it throws up dbus error as
> below. I tried googling from which I understand some people had the same
> error with 5.13 as well. The dbus version I have is 1.6.4 (I had to
> upgrade from 1.4 to build blueZ)
>  >
>  >
>  >> ./simple-agent hci0 00:1B:DC:07:2E:95
>  >> Traceback (most recent call last):
>  >>   File "./simple-agent", line 158, in <module>
>  >>     obj = bus.get_object(BUS_NAME, "/org/bluez");
>  >>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 241, in
> get_object
>  >>     follow_name_owner_changes=follow_name_owner_changes)
>  >>   File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 248,
> in __init__
>  >>     self._named_service = conn.activate_name_owner(bus_name)
>  >>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 180, in
> activate_name_owner
>  >>     self.start_service_by_name(bus_name)
>  >>   File "/usr/lib/python2.7/dist-packages/dbus/bus.py", line 278, in
> start_service_by_name
>  >>     'su', (bus_name, flags)))
>  >>   File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
> 651, in call_blocking
>  >>     message, timeout)
>  >> dbus.exceptions.DBusException:
> org.freedesktop.DBus.Error.Spawn.ChildExited: Launch helper exited with
> unknown return code 1
>  >
>  >
>  > Thank you for any suggestions or pointers in advance.
>  >
>  > Tony
>  >
>  >
>  > --
>  > To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
>  > the body of a message to majordomo@vger.kernel.org
> <mailto:majordomo@vger.kernel.org>
>  > More majordomo info at http://vger.kernel.org/majordomo-info.html
>
