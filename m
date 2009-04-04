Return-Path: <cyrus@holtmann.org>
Date: Sat, 4 Apr 2009 12:54:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez PIN generation in non-gui based application
Message-ID: <20090404095425.GA14455@jh-x301>
References: <6887eb5d0904032108k73484ee9p7b872bf0c492f0ed@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6887eb5d0904032108k73484ee9p7b872bf0c492f0ed@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Apr 04, 2009, Kartikey Parmar wrote:
> While cross compiling bluez-gnome-1.8, I found that it is dependent on
> GTK+ and GTK+ is dependent on ATK, PANGO, CAIRO.
> Is it possible to run bluez-gnome-1.8 application on simple linux that
> doesn't support GUI? or is there any other application available which
> can be used to generate linkkey from fixed PIN given?

You could e.g. make a minor modification to test/simple-agent to make it return
a fixed PIN in the RequestPinCode callback. Alternatively you try to update
test/agent.c to work with the new Agent interface.

Johan
