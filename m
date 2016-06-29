Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Gatt Client - RegisterApplication options
Date: Wed, 29 Jun 2016 11:50:12 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D7401C9@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D73E0E8@S0MSMAIL111.arc.local>
 <E92610C73D6DE84EB154DC52F5ECCE541D73F131@S0MSMAIL111.arc.local>,<CABBYNZKdT-ckFMzDEL9bz+pqsqttmnK5yg8gxCTTthOj+1JJGA@mail.gmail.com>
In-Reply-To: <CABBYNZKdT-ckFMzDEL9bz+pqsqttmnK5yg8gxCTTthOj+1JJGA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Luiz,

>Hi Johannes,

>On Tue, Jun 28, 2016 at 12:24 PM, Kropf Johannes
><Johannes.Kropf@ait.ac.at> wrote:
>> Hi,
>>
>> I upgraded to the newest version of bluez (5.40) and noticed that the "RegisterService" method to register the services for a client application is not existing anymore.
>>
>> However, I have troubles using the "RegisterApplication" method since I don't know how to put the profile hierarchy into the requested dict object. It is not clear for me, even after checking doc/gatt-api.txt and the source code.
>> Whatever I try results in the error message "No object received", invoked by the method
>> static void client_ready_cb(GDBusClient *client, void *user_data) in gatt-database.c

>I suspect that you don't have ObjectManager support, you can check
>tests/example-gatt-server how it is done in python, for other binding
>there should be a similar way to register the ObjectManager interface
>so bluetoothd is able to list the objects.

The ObjectManager Interface is available under the root of org.bluez, it is used also for finding devices as far as I understand.
The GetManagedObjects() method also works.
Which kind of object does bluetoothd try to find when calling the RegisterApplication method? 

Kind regards,
Johannes






