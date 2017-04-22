Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170422052644.GA31652@x1c>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
 <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
 <20170408071834.GA12144@x1c> <CAAu3APahskA_b2Ydt8TzUWBQnkuC10UwjZ37RaOyhAt4s1iyiQ@mail.gmail.com>
 <20170422052644.GA31652@x1c>
From: Barry Byford <31baz66@gmail.com>
Date: Sat, 22 Apr 2017 21:46:16 +0100
Message-ID: <CAAu3APZxRDoZhCU7QtWVNd05HbKzadoX=886r_REiebvmMj6vQ@mail.gmail.com>
Subject: Re: Serial Port connection with DBus API
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 22 April 2017 at 06:26, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Barry,
>
> On Fri, Apr 21, 2017, Barry Byford wrote:
>> >> >             'Channel': GLib.Variant('i', 1),
> ...
>> However I'm now seeing this error appear in btmon when I try to bind
>> to the RFCOMM socket:
>>
>> = bluetoothd: RFCOMM server failed for SerialPort: rfcomm_bind:
>> Address already in use (98)
>
> I think that means that you already have some other service listening on
> RFCOMM channel 1. Try using some other channel, or identify and stop the
> other service that's using channel 1.

Turns out it was me that was creating the other service. :-(

Depending which order I bind to the socket or RegisterProfile, depends
if I get the error in Bluetoothd or sockets.

I can register the Serial Port profile successfully which allows me to
connect from the (Bluedot) Android app and I can see information being
sent to my Linux board in btmon. However I don't seem to be able to
get at that information in my script.

Looking at this a bit more, maybe the socket connection should be
created from the 'fd' parameter passed to NewConnection. However when
I try to get the socket with this:

def NewConnection(self, path, fd, properties):
  self.server_sock = socket.fromfd(fd, socket.AF_BLUETOOTH, socket.SOCK_STREAM,
                                                       socket.BTPROTO_RFCOMM)
  data = self.server_sock.recv(1024)

It gives the following:

Exception while handling org.bluez.Profile1.NewConnection()
Traceback (most recent call last):
  File "/usr/local/lib/python3.5/dist-packages/pydbus/registration.py",
line 81, in call_method
    result = method(*parameters, **kwargs)
  File "BTclassic.py", line 67, in NewConnection
    data = self.server_sock.recv(1024)
OSError: [Errno 88] Socket operation on non-socket

I had been following test/test-hfp as the basic structure but that
doesn't seem to be working for me.

Not sure where to go next with this
