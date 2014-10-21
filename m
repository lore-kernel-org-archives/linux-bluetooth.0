Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Oct 2014 18:38:46 +0800
From: Qian Lei <qianl.fnst@cn.fujitsu.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: Confused about gatttool in Makefile.tools
Message-ID: <20141021183846.3ec677db@Fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all:

I don't understand the log message "build: Only compile actually
selected binaries" in commit ed7989e, which modifies the file
Makefile.tools. Gatttool and some other programs are only compiled and
do not been installed into system any more. I'm confused about it, why
did we do this?

Thanks.
Qian Lei
