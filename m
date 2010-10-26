Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Oct 2010 10:19:13 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ilya Basin <basinilya@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Re[2]: 4.76 possible regression: bluetoothd segfaults when
 launching bluetooth programs
Message-ID: <20101026141913.GA11973@jh-x301>
References: <453819375.20101024163802@gmail.com>
 <20101025204015.GA19748@jh-x301>
 <1602793498.20101026170445@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1602793498.20101026170445@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

On Tue, Oct 26, 2010, Ilya Basin wrote:
> JH> have all debug symbols enabled. Could you try to reproduce this with
> JH> latest bluez git. You don't need to install anything but just compile
> 
> segfaults start after this commit:
> [d5e700051b1263b2028331d41d60de02a5a6f90e] Fix append_variant_array()
> to take a number of elements
> 
> Not every BT program kills bluetoothd, but Smartcam does.
> http://sourceforge.net/projects/smartcam/
>   [il@IL bluez]$ smartcam
>   smartcam: registered DBUS service "org.gnome.smartcam"
>   Found smartcam device file: /dev/video0
>   smartcam: started comm thread
>   smartcam: port = 1
>   sdp_record_register: Protocol error

Thanks for the info. This program seems to add a somehow malformed
service record which is the cause of the crash. Before the patch you
pointed out a NULL pointer was used to detect the end of a pointer array
and so bt_uuid2string() returning NULL for this service record didn't
cause any bad behavior (since the code just stopped iterating a pointer
array after this). However after the patch the code uses an explicit
integer value for the list length and would try to dereference the NULL
pointer in the middle of the list.

I've now pushed a patch to git which should fix this:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=e31d21c7f238352893a365ab50642707c44087cd

Please do a git pull and see if it really fixes the issue for you.
Thanks.

Johan
