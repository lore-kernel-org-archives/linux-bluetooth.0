Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 8 Aug 2016 12:42:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kropf Johannes <Johannes.Kropf@ait.ac.at>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: 5.41 - Authentication Failed with kernel 4.2.0
Message-ID: <20160808094255.GA8136@t440s.lan>
References: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johannes,

On Mon, Aug 08, 2016, Kropf Johannes wrote:
> we had a problem when attempting to pair low energy devices on Ubuntu with kernel version 4.2.0-42-generic:
> After scanning there always occured an "authentication failed" error. 
> The devices we tried to pair were a A&D UC-352-BLE weighing scale and a A&D UA-651BLE blood pressure monitor. 
> Both devices can be paired on the same machine with the same setup but with kernel version 3.13.0.92. 
> Unfortunately the log doesn't give me an idea what the problem is.
>  
> Here is the output using bluetoothctl:
> [bluetooth]# pair 5C:31:3E:5E:54:5E 
> Attempting to pair with 5C:31:3E:5E:54:5E
> [CHG] Device 5C:31:3E:5E:54:5E Connected: yes
> Failed to pair: org.bluez.Error.AuthenticationFailed
> [CHG] Device 5C:31:3E:5E:54:5E Connected: no

Did you also have an agent registered? (e.g. "agent KeyboardDisplay" in
bluetoothctl)

What would give an even better view of what's going on is the HCI logs.
You can get those with the btmon tool (found under monitor/ in the BlueZ
source tree).

Johan
