Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKZqhqfEbuFELtqCkz2yz_YfoA8HNvxDMqT39h4X-V+CKxm7sQ@mail.gmail.com>
References: <CAKZqhqe-Go8T+LTvq48PL7FbLs8ffa7oySnC1Em7pK+nuoEQvw@mail.gmail.com>
	<CABBYNZ+0+XrPcq9WGZpehOMLPZ_NBHaukpX3CWfQDkCunVdtVw@mail.gmail.com>
	<CAM4ayVD5_GHr8PxE3E5dCNB9-+hHTSSh98rug-=YGmQ7+BLtjQ@mail.gmail.com>
	<CAKZqhqci7s16ofKQundHwTU=cEAJ-xsnVjNe7AYZciS8d1LyxQ@mail.gmail.com>
	<CAKZqhqfEbuFELtqCkz2yz_YfoA8HNvxDMqT39h4X-V+CKxm7sQ@mail.gmail.com>
Date: Mon, 20 Aug 2012 10:17:10 +0300
Message-ID: <CABBYNZKwosFmtx+4b82R2LkY_EyC1QYGM3Yjv-Hah-r-wcV50g@mail.gmail.com>
Subject: Re: GSoC: OBEX Filesystem In Userspace
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: dmp <dmp0x7c5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Vinicius Gomes <vcgomes@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Sat, Aug 18, 2012 at 7:52 PM, dmp <dmp0x7c5@gmail.com> wrote:
> Hello BlueZ Community,
>
> After Summer of Code we are reaching firm 'pencils down' date.
>
> Taking sentence from project's proposal: "Creating project using gobex
> will prove that library used by obexd has all the capabilities that
> open-obex has". I could definitely agree that gobex+glib based fuse
> filesystem - could replace obexfs. Prepared gobexfuse allows to
> listfolder, get, put, delete, mkdirs and move/copy files. From the
> user's point of view mounted gobexfuse behaves like local filesystem,
> just access time to larger files is noticeably slower due to bluetooth
> transfer.
>
> I've prepared (mentioned in previous e-mail) helpers middle layer
> between fuse and gobex operations. All functions declared by helpers.h
> could be easily used to write tool like obexftp (from openobex
> implementation). One think that I couldn't get tested (it's
> implemented) is rename operation (executed by g_obex_move).
> Unfortunately neither of my bluetooth devices supports this operation
> with their FTP profiles.

You can try against obexd, it does support move and copy action commands.


-- 
Luiz Augusto von Dentz
