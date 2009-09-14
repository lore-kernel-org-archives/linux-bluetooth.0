Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Sep 2009 15:13:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sasikiran Maddula <Madula.Sasikiran@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez stack issue with sco after headset profile disconnect
Message-ID: <20090914121345.GA3276@jh-x301>
References: <4AAA55D0.1050505@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AAA55D0.1050505@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sasikiran,

On Fri, Sep 11, 2009, Sasikiran Maddula wrote:
> I verified with different dongles in linux. The behavior is same in all  
> the cases. Firstly we will connect the headset using headset profile. We  
> will start skype call / some other sco connection. We will disconnect  
> the headset service from the headset profile. hcitool con says sco  
> connection is still available after disconnection successful. So, some  
> body suggest me how to stop the sco connection when we disconnect the  
> service.

You haven't mentioned which bluez and kernel versions you use but there
was a bug like this which got fixed. The fix was to call shutdown() before
close() for the SCO socket in bluetoothd (to force a disconnection even
though other processes, like skype, have copy of the socket), and add a
proper shutdown handler for SCO sockets on the kernel side. So you need
both the userspace fix (part of bluez since 4.42) as well as the kernel
fix. I'm not sure exactly which kernel version is needed but maybe Marcel
has an idea.

bluez patch:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=45873a73136b4c76353e445b8c6891b99dff89ce
kernel patch:
http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-testing.git;a=commitdiff;h=a0ed7b886953a1953d4aa6b3357c06096adb9cc7

Johan
