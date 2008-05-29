Return-Path: <cyrus@holtmann.org>
Message-Id: <6DFD696E-8181-4BCB-B4FA-3B4B295C84CF@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805290503g68474663n975cb2d1e7fc8e7a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 29 May 2008 22:43:43 +0200
References: <3e9cdced0805290503g68474663n975cb2d1e7fc8e7a@mail.gmail.com>
Subject: Re: [Bluez-users] correlation of hidd, hidp and the service Input
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Fritz,

> since I want to use a bluetooth keyboard in my Kernel 2.4.21 I'm  
> analyzing hidd, hidp and the Input service.
> At the same time I take a look at the alternative bthid from http://klausler.com/msbtkb-linux.html
>
> bthid consists of a daemon which implements the sdp stuff it  
> establishes connection to a hid device and send all received data to  
> the kernel modul fake through a character device.
> The kernel module simply forwads the received commands to the input  
> kernel module to get in keycodes into the kernel. That's it basically.
>
> Well what are the tasks of all the bluez HID parts:  hidd, hidp, the  
> Input Service, and how to they work/communicate with each other ?
> The problem is that I cant make the kernel module hidp run under my  
> 2.4 Kernel, maybe I can adapt it or replace it by another module.

start using a 2.6 kernel. That is really the answer to your problem.  
The rest is hacking around.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
