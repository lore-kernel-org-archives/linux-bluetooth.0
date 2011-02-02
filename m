Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 12:45:35 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vivek N <mail@vivekn.co.cc>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Interested in Contributing to BlueZ
Message-ID: <20110202144535.GA2273@joana>
References: <AANLkTikpZUi8ocU4Ntbn=ayX141ptTTY7zMOahuyxrTs@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikpZUi8ocU4Ntbn=ayX141ptTTY7zMOahuyxrTs@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vivek,

* Vivek N <mail@vivekn.co.cc> [2011-02-02 19:29:53 +0530]:

> Hi,
> 
> I am Vivek Narayanan, a sophomore undergraduate student from India. I
> am interested in contributing to BlueZ, the linux bluetooth project
> through GSoC (Google Summer of Code) or otherwise. I am really
> interested in working on a kernel and know C and Python quite well. I
> am downloading the git repository right now and am looking for some
> pointers on where to start first.

Nice that you want to contribute to BlueZ. :-)

To work with BlueZ you have first to have a good understanding of the
Bluetooth technology. For good reads are [0], [1], and many other stuff under
[2], like Profiles Overview and Architecture of many layers.

Unfortunately the only documentation we have is the source code and the git
history.

Then you have to choose some part that you want to focus on, BlueZ is a very
big project with extensive Bluetooth specifications. You won't understand all
of then easily.

We are going to setup a web page soon with project proposals for the Google
Summer of Code. It will help students choose an area in BlueZ to work on.

And a very quick overview of Bluetooth Stack in Linux: Many core parts of the
Bluetooth stack is implemented in the Linux Kernel, the HCI; L2CAP and SCO
(synchronous audio) layers; and the BNEP and RFCOMM protocols. All the rest is
done by the bluetoothd daemon in the userspace, or the obexd daemon (which is
also part of the BLueZ project, but resides in another git though).

Besides that, you have to know a bit about DBus and glib. They are two important
parts of the BlueZ.


[0] http://en.wikipedia.org/wiki/Bluetooth
[1] http://bluetooth.com/English/Technology/Works/Pages/Overview_of_Operation.aspx
[2] http://bluetooth.com/English/Technology/Works/Pages/default.aspx

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
