Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150819161441.GA8142@hau.nz>
References: <20150818220604.05b7a862@angwin.home>
	<CABBYNZLJQchUh7z1xCfmmuVq1Nexx3RYLB0AUq+DWUFpo-=gnw@mail.gmail.com>
	<CABBYNZ+qjOtB4=qba6DF+KY5wiYnhCFcMX4fPSrHRrVDx0R04w@mail.gmail.com>
	<20150819161441.GA8142@hau.nz>
Date: Wed, 19 Aug 2015 19:54:56 +0300
Message-ID: <CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
Subject: Re: IdleTimeout behavior for Sony PS3 remote in Bluez 5
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mark Haun <haunma@keteu.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mark,

On Wed, Aug 19, 2015 at 7:14 PM, Mark Haun <haunma@keteu.org> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz [luiz.dentz@gmail.com] wrote:
>> >> I have set IdleTimeout=1 in /etc/bluetooth/input.conf.  My
>> >> understanding is that this should disconnect from the remote after one
>> >> minute of inactivity.  What I find, however, is that after exactly one
>> >> minute, the *input device* disappears (i.e. no longer listed
>> >> in /proc/bus/input/devices) but the connection to the remote remains
>> >> active.  Ten or twenty minutes later, it still shows as "Connected" in
>> >> bluetoothctl or hcitool con:
>> >>
>> >> Connections:
>> >>         > ACL 00:21:4F:48:D1:D2 handle 256 state 1 lm MASTER
>> >
>> > Yes, IdleTimeout should disconnect the device in case there is nothing
>> > else connect (no other sockets except HID), but note that IdleTimeout
>> > currently does not work with UserspaceHID.
> [...]
>> > Looks like the sockets are not really closed then thus keeping the ACL
>> > active which is probably a bug, does bluetoothd logs indicate a
>> > disconnection or it is just the input device that disappears?
>
> Thanks, it's good to know that this is the expected behavior.  But what do
> you mean by "userspace HID"?  I am only using evdev (via Python).

That is another option you can use in input.conf, so you are probably
no using if you didn't change anything.

> Tonight I will run the experiment again with "bluetoothd -n -d" and let you
> know what happens.  I already see some errors about the sap driver
> initialization failing, but that may be unrelated.
>
>> > This depend from device to device, usually this policy is done by the
>> > device itself since it knows better when it should be disconnected so
>> > usually IdleTimeout is used only for *broken devices that don't
>> > implement any policy to conserve their own batteries most likely
>> > because windows driver have these policies built in, perhaps we also
>> > should have this kind of policy in the input driver but I don't know
>> > if there is any support to disconnect a device after a period of
>> > inactivity.
>>
>> Apparently the following lines were removed in the commit
>> 5205185d461d5902325e457ca80bd421127b7308:
>>
>> -       /* Wakeup user-space polling for socket errors */
>> -       session->intr_sock->sk->sk_err = EUNATCH;
>> -       session->ctrl_sock->sk->sk_err = EUNATCH;
>>
>> Without this I doubt the userspace will realize that it should release
>> the sockets which means this as been broken for over 2 years and
>> probably nobody realized up until today, it is probably only useful
>> when IdleTimeout is set since it is the only case where the module
>> itself device to remove the device and disconnect.
>
> The PS3 remote is definitely one of those broken devices.  During bluez 4.xx
> there were a set of unofficial patches maintained at kitlaan.twinaxis.com
> (now defunct).  Not a long-term tenable solution, although I was never clear
> on whether all his changes were actually necessary in later bluez versions.
> It seems like IdleTimeout should be enough, if it can be made to disconnect.
> Reconnect and evdev init works just fine on the next keypress.

Patches to what exactly, BlueZ userspace, kernel? Note that using
IdleTimeout affects every single HID that you connect over Bluetooth,
which is why I think this is in the wrong place, it should probably be
up to the PS3 remote driver to implement such policy to disconnect on
idle. Either way I don't see another option other then to set the
socket err so userspace can cleanup it own reference to the socket.


-- 
Luiz Augusto von Dentz
