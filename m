Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when unpairing without disconnecting
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4q2ii0jGLXuBVu1ZOOqmQQ+m+zCne-Jizzjr6UkfcgWXA@mail.gmail.com>
Date: Sat, 11 Oct 2014 10:44:48 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A1127958-39FE-4FFB-886F-78607D00679F@holtmann.org>
References: <1412859828-6224-1-git-send-email-fons@spotify.com> <CAHF=Y4oTZjk6k0YeBA6xEpksZRWU1TTtkZfB+YESWmmRxNs0GA@mail.gmail.com> <872F1D49-E810-4D33-9B05-ED3DDBA64336@holtmann.org> <CAHF=Y4q2ii0jGLXuBVu1ZOOqmQQ+m+zCne-Jizzjr6UkfcgWXA@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

>> I am not in favor of making Pair Device just do re-pairing. I think that is a dangerous behavior since want bondings in the kernel only in two ways. Either they are loaded via Load Long Term Keys or via Pair Device. Doing something magic is something that I consider dangerous and can lead into some flaws. If we come with a clear error than we at least know that something went wrong.
>> 
>> Repairing command is possible, but I am not 100% convinced that it is a good idea. The normal workflow is that you pair and unpair a device. If you get stuck in a weird state, you unpair first which ensures that everything is cleaned out and then pair again. For the connection parameters we can just be smarter.
> 
> Fair enough. Does this mean that the current patch is still of
> interest? I hope so :)

the kernel side for delaying the removal of the connection parameters is the right thing to do. We should have done in the first place actually.

>> I bet there is still a lot of improvement for our connection parameter handling. For example we could just keep all connection parameters around in cache and just expire them after 1 day or so. That would improve general handling with devices with do not pair in the first. So I would focus on being smart when dropping connection parameters and not trying to bind it too much to mgmt API visible states.
> 
> I actually have a patch lying around which keeps track of
> conn_parameters within bluetoothd. I think that it would be a good
> start (I would like to complete the submissions I sent this week
> getting to it though).

I am not in favor of that. bluetoothd is supposed to be stupid when it comes to these values. I mean stupid in a sense that when the kernel tells us to store them (conn params, IRK, LTK etc.), the daemon will store them. And on reboot just reload the whole thing back into the kernel. On unpairing/removing a device, the only other thing the daemon is suppose to be doing is clear all we know about that device. Meaning removing all stored keys and params. That is all it is suppose to be doing. Plain and simple.

This basic concept has gotten us pretty far and allowed us to put the kernel in control of handling the nasty details when it comes to pairing and connection handling.

But as I said before, we can be smarter inside the kernel. So the advertising data can actually contain proposed connection interval values from the peripheral. A peripheral can you tell the central its preferred values from the start. We are currently not parsing the advertising data and pre-filling the connection request with these values from the advertising report. That is something we could do. That will clearly improve our handling of peripherals that do not create a bond with us.

And for peripherals that do not keep a bond with us, we can actually just keep the connection parameters for x amount of time and then expire them like we expire the inquiry cache. That is exactly how the inquiry cache in BR/EDR works to speed up the connection creation. We will try to re-read the clock offset before terminating a connection so that when you do a re-connection right away, we use the right clock offset.

There are tons of improvements that we can do. And most of them can be done without changing any behavior in bluetoothd or changing the mgmt API.

Regards

Marcel

