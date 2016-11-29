Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APY8oK4O57fbwzULRHiMnVT+75KQEbOaAEQRp-W6rJaWHw@mail.gmail.com>
References: <20161123214013.GZ35881@redhat.com> <CABBYNZKYf3b8zTzGFNqd_3LGxYZkgo_g4LRs=jf=_qYS3fj1vA@mail.gmail.com>
 <20161128205526.GP35881@redhat.com> <CAAu3APY8oK4O57fbwzULRHiMnVT+75KQEbOaAEQRp-W6rJaWHw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Nov 2016 14:45:21 +0200
Message-ID: <CABBYNZ+7n3HR50ENp-Zjjb0uUM=YPPpP5ndRA38w9+gqXROFRw@mail.gmail.com>
Subject: Re: d-bus or management api for beacon stuff
To: Barry Byford <31baz66@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry, Don,

On Tue, Nov 29, 2016 at 2:24 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello Don,
>
>
> On 28 November 2016 at 20:55, Don Zickus <dzickus@redhat.com> wrote:
>> On Thu, Nov 24, 2016 at 03:07:21PM +0200, Luiz Augusto von Dentz wrote:
>>> Hi Don,
>>>
>>> On Wed, Nov 23, 2016 at 11:40 PM, Don Zickus <dzickus@redhat.com> wrote:
>>> > Hi,
>>> >
>>> > I was trying to write some code to continuously scan the bluetooth field
>>> > for bluetooth devices sending advertising packets (ie beacon-mode).
>>>
>>> That is tricky, if you have anyone else trying to use the adapter in
>>> this situation it will probably be blocked, we may add support for
>>> setting intervals but that will probably be a best effort in case
>>> there is no connection or other usage of the adapter by the system.
>>>
>>> > These devices would come and go so I wanted to avoid the cache.
>>>
>>> Beacon are not normally not connectable, connections and continuous
>>> advertisement don't go well together so we will probably have to
>>> reduce the intervals in order to maintain any traffic on the
>>> connections.
>>
>>
>> Hi Luiz,
>>
>> Thanks for the response.  I am wondering if I explained it wrong.  I wasn't
>> looking to do advertisements but instead scan for advertisements.  I also
>> don't plan to connect to any of the advertising device, just read the
>> advertised data.
>>
>>
>>>
>>> > I noticed the D-Bus interface doesn't quite allow me to do this (as it
>>> > caches the devices and I can't monitor the RSSI field).  But I think the
>>> > bluetooth management interface does. Is that the correct approach?
>>>
>>> Yep you could in theory use the MGMT interface and manually add you
>>> beacon management on top, but I guess you don't want applications to
>>> do that since it would require root permissions to connect to the
>>> management socket, so making bluetoothd, via kernel?, to adjust the
>>> intervals is probably a better idea in the long run. We would probably
>>> have to maintain the biggest advertising window possible, and the
>>> consider:
>>>
>>> 1.  Is it connectable/there any advertising instance that is
>>> connectable? If yes, the it has to adjust the window to allow them
>>> (perhaps using the default connection parameters).
>>> 2.  In case of a connection is made the controller may not be able to
>>> advertise anymore, and in case it can still advertise we need to make
>>> sure it doesn't interrupt the connection (this is not very clear if
>>> the controller is suppose to manage this somehow).
>>> 3. Similar to the connection situation we may have application
>>> scanning, again there might be problems if the controller cannot scan
>>> while advertising we would probably have to stop advertising.
>>
>> Hmm, as I said above, I am wondering if I explained it wrong.
>>
>> I was wondering how much was already done because in reality, I was just
>> going to mimic what android does on the phones with apple ibeacons except my
>> machines stay put and the ibeacons travel.
>>
>> Currently I was using 'hcitool lescan --duplicates' and 'hcidump' and trying
>> to script that.  But wanted to be smarter. :-)
>
> I am planning on doing a similar application as you describe and
> understood that you should be able to do much of what you want with
> the dbus API.
> Have you taken a look at adapter/StartDiscovery?
> It is documented at
> git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt#n12
> You would then monitor the PropertiesChanged signal on the system dbus.
>
> SetDiscoveryFilter might also be necessary/helpful.

Yep, the SetDiscoveryFilter might be the way to go, the only missing
part that it doesn't do right now is to disable duplicate filtering,
but we might need some flag with a big warning that this will spam the
bus like crazy or perhaps it can only be used along RSSI filtering,
which is to prevent people to use advertisement/scanning APIs as a
transport over D-Bus.

We could offer a file descriptor based solution for transport
emulation using scanning/advertising to prevent spamming D-Bus but
that has to play nicely with other application, either that or we only
allow this over MGMT interface which is what we suggest in case there
is no other use for Bluetooth in the system.

And btw, I wouldn't account Android and other mobile OSes allowing
such raw access for much longer, it takes way too much power and can
probably block any other Bluetooth peripheral to work, so it is
probably only good to write packet sniffer and other debug tools on
top of the system but it really offer nothing to the regular user.

-- 
Luiz Augusto von Dentz
