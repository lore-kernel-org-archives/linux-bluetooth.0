Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimKgn-_RzoFL8Mi1-CVAq2TWywbew@mail.gmail.com>
References: <BANLkTik1Onu+9EWdi+ZzP5tZD0-f+UgyZQ@mail.gmail.com>
	<BANLkTincgvG1WftEUjXWBDEhpP=sTFTkCA@mail.gmail.com>
	<BANLkTimKgn-_RzoFL8Mi1-CVAq2TWywbew@mail.gmail.com>
Date: Tue, 7 Jun 2011 09:23:44 +0200
Message-ID: <BANLkTimhM0qcoiNw0k3f5RFc4pruDDyhNQ@mail.gmail.com>
Subject: Re: Build bluez without dbus
From: Jacques Dirac <jacquesdirac@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you all for the responses.

>> Is there some configure parameter, patch or tutorial to build bluez
>> without dbus? Or with dbus, but without glib?
>
> The answer is no, those are very common dependencies on any
> system/distribution that why we use them in the core daemon and they
> fit pretty well in our design.

I understand.

> If you just need some basic function (inquiry), you can just write some code
> directly on HCI with socket.
> It is not very difficult by taking the reference to the implementation of
> hcitool.

My program is similar to hcitool, so I just need bluetooth.c and
hci.c. I was hoping that the full build could give me a shared library
which contained all these functions.
I want to separate my code from the bluetooth code, so now I created a
shared library from the mentioned files myself. This works great for
me!

The next step is to create a simple program (again without GUI) that
can send out (push) bluetooth messages (like advertising). Have you
got some hints on that?

Best regards.
