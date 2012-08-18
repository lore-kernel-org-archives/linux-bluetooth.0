Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKZqhqci7s16ofKQundHwTU=cEAJ-xsnVjNe7AYZciS8d1LyxQ@mail.gmail.com>
References: <CAKZqhqe-Go8T+LTvq48PL7FbLs8ffa7oySnC1Em7pK+nuoEQvw@mail.gmail.com>
	<CABBYNZ+0+XrPcq9WGZpehOMLPZ_NBHaukpX3CWfQDkCunVdtVw@mail.gmail.com>
	<CAM4ayVD5_GHr8PxE3E5dCNB9-+hHTSSh98rug-=YGmQ7+BLtjQ@mail.gmail.com>
	<CAKZqhqci7s16ofKQundHwTU=cEAJ-xsnVjNe7AYZciS8d1LyxQ@mail.gmail.com>
Date: Sat, 18 Aug 2012 18:52:23 +0200
Message-ID: <CAKZqhqfEbuFELtqCkz2yz_YfoA8HNvxDMqT39h4X-V+CKxm7sQ@mail.gmail.com>
Subject: Re: GSoC: OBEX Filesystem In Userspace
From: dmp <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Gomes <vcgomes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello BlueZ Community,

After Summer of Code we are reaching firm 'pencils down' date.

Taking sentence from project's proposal: "Creating project using gobex
will prove that library used by obexd has all the capabilities that
open-obex has". I could definitely agree that gobex+glib based fuse
filesystem - could replace obexfs. Prepared gobexfuse allows to
listfolder, get, put, delete, mkdirs and move/copy files. From the
user's point of view mounted gobexfuse behaves like local filesystem,
just access time to larger files is noticeably slower due to bluetooth
transfer.

I've prepared (mentioned in previous e-mail) helpers middle layer
between fuse and gobex operations. All functions declared by helpers.h
could be easily used to write tool like obexftp (from openobex
implementation). One think that I couldn't get tested (it's
implemented) is rename operation (executed by g_obex_move).
Unfortunately neither of my bluetooth devices supports this operation
with their FTP profiles.

Currently, with help from Vinicius code should be adopted to be in a
reviewable state and then we could think about integration with obexd
upstream.

Thanks,
Michal
