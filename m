Return-Path: <linux-kernel-owner+marcel=40holtmann.org-S1751336AbWLXNnS@vger.kernel.org>
Message-ID: <458E8407.1050504@gmail.com>
Date: Sun, 24 Dec 2006 14:43:12 +0059
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
        marcel@holtmann.org, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
References: <20061223234305.GA1809@elf.ucw.cz>	<20061223235501.GA1740@elf.ucw.cz>	<20061224000150.GA1812@elf.ucw.cz>	<20061224000605.GA1768@elf.ucw.cz>	<20061224000753.GA1811@elf.ucw.cz>	<458DD459.2030209@gmail.com>	<458E69CB.6000107@gmail.com> <20061224042225.51a6619a.akpm@osdl.org>
In-Reply-To: <20061224042225.51a6619a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-devel.lists.sourceforge.net>

Andrew Morton wrote:
> On Sun, 24 Dec 2006 12:51:16 +0059
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> [   58.674780] EFLAGS: 00010046   (2.6.20-rc1-mm1 #207)
> 
> please, test 2.6.20-rc2.  We applied a fix for this.

It's working now.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
