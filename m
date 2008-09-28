Return-Path: <cyrus@holtmann.org>
Message-Id: <5D375EC5-69D1-4263-AACF-DAACD60D064D@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <95c807760809281058y3c9b15d3j19ebc4bbe9df59b2@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Bluez 4.7 crash pairing Motorola S9 w/bt
Date: Sun, 28 Sep 2008 23:52:33 +0300
References: <95c807760809281058y3c9b15d3j19ebc4bbe9df59b2@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

On Sep 28, 2008, at 20:58, Tim Dempsey wrote:
> I was attempting to pair a set of Motorola S9 headphones using bluez  
> 4.7
> and received the following crash. Attached is the output of  
> 'bluetoothd -nd'
> under gdb, with a bt. I also included the output of
> "dbus-monitor --system sender='org.bluez'". I made the following  
> patch and
> thought I'm sure it's not the right fix it allowed me to pair/play  
> sound
> though the S9.

Thanks for catching this issue. It's related to the pairing code  
changes I made for 4.7. I did see the assert too once but was unable  
to reproduce it later and so didn't spend more time wondering about  
it. For some reason it also didn't cause SIGABRT to me (maybe related  
to me running valgrind?). Anyway, as you doubted, your fix isn't  
really correct since it will make the PropertyChanged signal not be  
sent when in fact we want it to be sent. The issue is that when we do  
service discovery due to a remotely initiated pairing attempt there's  
no DBusConnection pointer assosiated to the browse request and so the  
emit_property_changed function gets a NULL pointer instead of a proper  
DBusConnection*. I just pushed a fix to the git where the code that  
calls emit_property_changed will get a valid DBusConnection via  
get_dbus_connection() and use that instead of the request specific one.

Johan
