Return-Path: <cyrus@holtmann.org>
Message-ID: <51dad0b8500cb7904dbe3438b15c5a7c.squirrel@mungewell.org>
In-Reply-To: <0e8e81b360e2f3c5ff9fc6c26b447462.squirrel@mungewell.org>
References: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
    <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
    <8297c42b69d89cb9326b938a9adaa997.squirrel@mungewell.org>
    <913a160c809900ee52e7c83350b4162f.squirrel@mungewell.org>
    <55A8AA15.2050802@ti.com>
    <d51df2e1e321efc18d74f3cc33bd4106.squirrel@mungewell.org>
    <55A93A10.3060201@redhat.com>
    <0e8e81b360e2f3c5ff9fc6c26b447462.squirrel@mungewell.org>
Date: Sun, 19 Jul 2015 21:48:22 -0400
Subject: Re: Kernel Oops: btusb: 4.2rc1 System lockup with BT dongle insert -
 log attached
From: simon@mungewell.org
To: simon@mungewell.org
Cc: "Laura Abbott" <labbott@redhat.com>,
	"Shuah Khan" <shuahkh@osg.samsung.com>,
	"Kim, Milo" <milo.kim@ti.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6f957724b94cb19f5c1c97efd01dd4df8ced323c
>>
>
> Certainly looks like a plausible solution, will build kernel tonight to
> confirm.

Just to confirm; 4.2rc1 + above patch, and 4.2rc2 both function correctly
and I no longer see the lock up/Oops.

Thanks to all who helped out,
Simon.

