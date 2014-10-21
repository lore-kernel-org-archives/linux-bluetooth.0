Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: Confused about gatttool in Makefile.tools
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141021183846.3ec677db@Fedora>
Date: Tue, 21 Oct 2014 04:12:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <830724D3-5CFE-4838-BE86-777836B8B90D@holtmann.org>
References: <20141021183846.3ec677db@Fedora>
To: Qian Lei <qianl.fnst@cn.fujitsu.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Quian,

> I don't understand the log message "build: Only compile actually
> selected binaries" in commit ed7989e, which modifies the file
> Makefile.tools. Gatttool and some other programs are only compiled and
> do not been installed into system any more. I'm confused about it, why
> did we do this?

some tools are only useful to developers. They should not be installed. We only install tools that are generally useful (or considered legacy like hciconfig).

The jump to BlueZ 5 came with a massive cleanup of our tools and only a selected few get installed. Main operation should be done with bluetoothctl these days.

Regards

Marcel

