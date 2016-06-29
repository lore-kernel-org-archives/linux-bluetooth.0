Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D7401C9@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D73E0E8@S0MSMAIL111.arc.local>
 <E92610C73D6DE84EB154DC52F5ECCE541D73F131@S0MSMAIL111.arc.local>
 <CABBYNZKdT-ckFMzDEL9bz+pqsqttmnK5yg8gxCTTthOj+1JJGA@mail.gmail.com> <E92610C73D6DE84EB154DC52F5ECCE541D7401C9@S0MSMAIL111.arc.local>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 Jun 2016 15:33:36 +0300
Message-ID: <CABBYNZKXaich4vK5L=41_PqhayVHLzrEq3GevoPtrP2UAj6iCg@mail.gmail.com>
Subject: Re: Gatt Client - RegisterApplication options
To: Kropf Johannes <Johannes.Kropf@ait.ac.at>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

On Wed, Jun 29, 2016 at 2:50 PM, Kropf Johannes
<Johannes.Kropf@ait.ac.at> wrote:
> Dear Luiz,
>
>>Hi Johannes,
>
>>On Tue, Jun 28, 2016 at 12:24 PM, Kropf Johannes
>><Johannes.Kropf@ait.ac.at> wrote:
>>> Hi,
>>>
>>> I upgraded to the newest version of bluez (5.40) and noticed that the "RegisterService" method to register the services for a client application is not existing anymore.
>>>
>>> However, I have troubles using the "RegisterApplication" method since I don't know how to put the profile hierarchy into the requested dict object. It is not clear for me, even after checking doc/gatt-api.txt and the source code.
>>> Whatever I try results in the error message "No object received", invoked by the method
>>> static void client_ready_cb(GDBusClient *client, void *user_data) in gatt-database.c
>
>>I suspect that you don't have ObjectManager support, you can check
>>tests/example-gatt-server how it is done in python, for other binding
>>there should be a similar way to register the ObjectManager interface
>>so bluetoothd is able to list the objects.
>
> The ObjectManager Interface is available under the root of org.bluez, it is used also for finding devices as far as I understand.

Yep, but in this case we are looking for the ObjectManager in the
application side not in bluetoothd.

> The GetManagedObjects() method also works.
> Which kind of object does bluetoothd try to find when calling the RegisterApplication method?

It does call GetManagedObjects, we use that to enumerate the services
the application has and then proceed to register them.


-- 
Luiz Augusto von Dentz
