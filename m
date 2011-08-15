Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOnmHE99xws9FE55mMWtGfMEn8xh41uvZvBnfVZBCe+HccpRfA@mail.gmail.com>
References: <CADhZqEfUBm3eTVpvhWxiDjar7c3jRewpEU+u1ZxKUDwnQR6LEA@mail.gmail.com>
 <CAOnmHE99xws9FE55mMWtGfMEn8xh41uvZvBnfVZBCe+HccpRfA@mail.gmail.com>
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Mon, 15 Aug 2011 21:37:20 +0530
Message-ID: <CAOnmHE-3qbgLQcY8gCEGQudJJhPcq3QyVCujFD1V4w-xA0m1sA@mail.gmail.com>
Subject: Re: bluez hierarchy overview
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hi,
>
> I need some help in understanding Bluez file hierarchy and purposes of
> each file in it. Folder structure is still unclear for me. Ok, i
> understand, that in folder "spb" lays SBC codec driver, in "doc"
> folder - Bluez D-Bus API documentation. It's obviously. But in Bluez
> root there are a lot of other folders with a lot of files. For example
> in which folder i can find a linux kernel's modules?

You are referring to user space component of Bluez stack. The kernel
components can be found in net/bluetooth directory of kernel source.

>
> Which is the
> "main" bluez folder? "Lib"? What does "plugin" mean for Bluez?
>
 main dir refers to the directory handling the Bluetooth daemon source
and its entry. Plugin re kind of applications that run in context of
Bluetooth daemon. Bluez profiles are typically implemented as either
Bluetooth daemon or Obex daemon plugins.

Thanks,
Arun
