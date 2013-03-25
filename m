Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130325162309.GA25769@x220.P-661HNU-F1>
References: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
	<20130325162309.GA25769@x220.P-661HNU-F1>
Date: Mon, 25 Mar 2013 12:36:18 -0400
Message-ID: <CAB8sVA-r2EnKTKWT+tp-eQo0r-nFS58cwpF_gNQ9Hi_v7xtZsA@mail.gmail.com>
Subject: Re: Problem Running Bluez Tests
From: Brendan West <extremeskateboarding@gmail.com>
To: Brendan West <extremeskateboarding@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

On Mon, Mar 25, 2013 at 12:23 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Brendan,
>
> On Mon, Mar 25, 2013, Brendan West wrote:
>  ./test-heartrate -i hci1 -b FC:4E:09:DC:68:44
>> Traceback (most recent call last):
>> File "./test-heartrate", line 62, in <module>
>> managed_objects = bluezutils.get_managed_objects()
>> File "/home/user/Downloads/bluez-5.2/test/bluezutils.py", line 11, in
>> get_managed_objects
>> return manager.GetManagedObjects()
>> File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
>> return self._proxy_method(*args, **keywords)
>> File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
>> **keywords)
>> File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651,
>> in call_blocking
>> message, timeout)
>> dbus.exceptions.DBusException:
>> org.freedesktop.DBus.Error.UnknownMethod: Method "GetManagedObjects"
>> with signature "" on interface "org.freedesktop.DBus.ObjectManager"
>> doesn't exist
>
> This sounds like you still have an old (4.x) bluetoothd running. You'll
> need to stop it and start the one you compiled from the 5.x tree. Also
> be sure to install a new D-Bus policy (src/bluetooth.conf to
> /etc/dbus-1.system.d/) since a lot of interface names have changed since
> 4.x.
>
> Johan

That sounds like it could be the problem.  However, shouldn't the old
bluetoothd stop and the new one start when I reboot the Raspberry Pi?
Or do I actually have to do it manually?  If the latter, can you
explain how to do so (I am not sure how two different versions can be
installed at the same time..I was under the impression that a normal
install of the new would overwrite the old).

As for the D-Bus policy, I'm afraid that I am still not sure how to do
that one either..  I have updated D-Bus using apt-get, but you seem to
be referring to something else..  Would you mind explaining further?

Thanks for your help, and I apologize for being  completely clueless
to what you are talking about..I've only been using Linux for a short
time haha.  Thanks again.

Brendan West
