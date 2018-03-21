Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOT_U5Y+GLS1VU_hJs0fi1_Z0xDcL5eYMAzpgknD1aJ-GbKwiQ@mail.gmail.com>
References: <CAOT_U5Y+GLS1VU_hJs0fi1_Z0xDcL5eYMAzpgknD1aJ-GbKwiQ@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 21 Mar 2018 15:27:51 +0000
Message-ID: <CAJTo0LbZi2P+qjJ-d3Bq1npsrsWJ9CNznXdc+zxd8w_KhJKEiw@mail.gmail.com>
Subject: Re: [yocto] Building BlueZ from git in Yocto
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 21 March 2018 at 15:15, Alan Martinovic <alan.martinovic@senic.com> wrote:
> Building it with Yocto results in the mentioned error:
>
> | ../git/src/genbuiltin hostname wiimote autopair policy   a2dp avrcp network input hog  gap scanparam deviceinfo  battery > src/builtin.h
> | ../git/obexd/src/genbuiltin filesystem bluetooth  opp ftp irmc pbap mas mns > obexd/src/builtin.h
> | /bin/bash: obexd/src/builtin.h: No such file or directory
> | Makefile:9431: recipe for target 'obexd/src/builtin.h' failed
> | make: *** [obexd/src/builtin.h] Error 1
> | make: *** Waiting for unfinished jobs....
> | ERROR: oe_runmake failed
> | WARNING: exit code 1 from a shell command.
>
>
> It seems that for some reason in Yocto, make can't redirect into `obexd/src/builtin.h` while
> it does so successfully for native build.

Yocto will be doing an out-of-tree build with high parallelism,
neither of which you are likely doing yourself.

The hint is "no such file or directory" for a file it is writing *to*.
This means the parent doesn't exist, in this case obexd/src/.

This is a typical race in out-of-tree and parallel builds, where
genbuiltin is racing against other commands to create the directory.
The fix is to ensure that whatever rule calls genbuiltin actually does
a mkdir first.

We have a fix for this already in oe-core:

http://git.openembedded.org/openembedded-core/tree/meta/recipes-connectivity/bluez5/bluez5/out-of-tree.patch

So I imagine you're using an old release of Yocto.  I sent this patch
to the linux-bluetooth list in April 2016 but it was either moderated
away or missed.

Ross
