Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 23:00:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Anton Weber <anton@antweb.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: GSoC: Bluetooth Replayer update
Message-ID: <20120522020004.GG16942@joana>
References: <CA+6PnXxc8CQ7q6LGkDWbP_-2P+4U_MX3rTt237PHhN2nGXeYag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+6PnXxc8CQ7q6LGkDWbP_-2P+4U_MX3rTt237PHhN2nGXeYag@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

* Anton Weber <anton@antweb.me> [2012-05-21 19:39:49 +0100]:

> Hello everyone!
> 
> Now that the coding period for GSoC started, I will be regularly
> posting updates to the mailing list.
> This is meant to share my progress, but also to get get the community involved.
> If you have any feedback or suggestions, about the things I wrote or
> about my project in general, please let me know!
> As mentioned in my first email, you can always contact me directly via
> email or IRC as well.
> 
> To give everyone a better idea of what my project is about, I have
> uploaded the initial project proposal:
> http://antweb.me/tl_files/blog/gsoc12/gsoc_proposal.pdf
> I will do things slightly differently now that I have more of an idea
> what I'm dealing with, but the main structure should stay the same.
> 
> What happened so far:
> - read up on various guides and the Bluetooth specification
> - played around with git (will upload my work to github once I got
> that far and possibly fork the bluez repo at some point if required)
> - went through hcidump sources (found many bits of code I can reuse,
> especially the parser)
> - had a look at hciemu, but didn't get too far yet
> 
> Next up:
> - Find out more about hciemu
> - Getting used to automake
> - Write a tool that can execute a simple sequence of commands on a
> VHCI interface.
>   I will start off with a standalone tool for now, but it might be a
> good idea to integrate it in hcidump (more about that when I got that
> far).

Actually you should use btmon here, instead hcidump. btmon can log starting
from the time you plug the bluetooth dongle.
And we have btsnoop output there too, I think you can use it to extract the
data to replay.

	Gustavo
