Return-Path: <akpm@osdl.org>
Date: Sun, 24 Dec 2006 04:22:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
        marcel@holtmann.org, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
Message-Id: <20061224042225.51a6619a.akpm@osdl.org>
In-Reply-To: <458E69CB.6000107@gmail.com>
References: <20061223234305.GA1809@elf.ucw.cz>
	<20061223235501.GA1740@elf.ucw.cz>
	<20061224000150.GA1812@elf.ucw.cz>
	<20061224000605.GA1768@elf.ucw.cz>
	<20061224000753.GA1811@elf.ucw.cz>
	<458DD459.2030209@gmail.com>
	<458E69CB.6000107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 24 Dec 2006 12:51:16 +0059
Jiri Slaby <jirislaby@gmail.com> wrote:

> [   58.674780] EFLAGS: 00010046   (2.6.20-rc1-mm1 #207)

please, test 2.6.20-rc2.  We applied a fix for this.
