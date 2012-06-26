Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAM4ayVD5_GHr8PxE3E5dCNB9-+hHTSSh98rug-=YGmQ7+BLtjQ@mail.gmail.com>
References: <CAKZqhqe-Go8T+LTvq48PL7FbLs8ffa7oySnC1Em7pK+nuoEQvw@mail.gmail.com>
	<CABBYNZ+0+XrPcq9WGZpehOMLPZ_NBHaukpX3CWfQDkCunVdtVw@mail.gmail.com>
	<CAM4ayVD5_GHr8PxE3E5dCNB9-+hHTSSh98rug-=YGmQ7+BLtjQ@mail.gmail.com>
Date: Tue, 26 Jun 2012 03:12:47 +0200
Message-ID: <CAKZqhqci7s16ofKQundHwTU=cEAJ-xsnVjNe7AYZciS8d1LyxQ@mail.gmail.com>
Subject: Re: GSoC: OBEX Filesystem In Userspace
From: dmp <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Gomes <vcgomes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello BlueZ Community,

During past GSoC weeks I did research on gobex library and developed
pieces of code useful for project. I've created special branch called
"playground" in my repository to do code examples.

Obexd code was extremely helpful, especially the client part. Thanks
to all examples from obexd source I produced some kind of middle layer
between g_obex_ and fuse code, I put it inside helpers.c[1].
Currently, I'm focused on folder listing, which looks the most
comlicated. Using mentioned helpers I was able to get file list inside
fuse driver. It's implemented in fusetest.c[2] and It was a really
great moment to see the very first "ls" command on gobex filesystem
that lists files from root directory at my phone :)

Some aspects was more complicated than I expected. For example
ListFolder operation couldn't be done using "higher-level" gobex
operations, it requires to create new request and add special phrase
"x-obex/folder-listing" to header. I had also strange problem with my
HTC phone, it was refusing every first connection after sdp scan. My
older Sony Ericsson hasn't got such issue. As Vinicius suggested I've
updated my kernel and it started working properly :)

I'm really happy to code for BlueZ. I'll keep on developing. As a side
note I'm really surprised by glib, this is my first project using it
and it really helps to "Write in C"[3].

[1] https://github.com/dmp0x7c5/gobexfuse/blob/playground/fuse/helpers.c
[2] https://github.com/dmp0x7c5/gobexfuse/blob/playground/fuse/fusetest.c
[3] http://youtu.be/XHosLhPEN3k

Thanks,
Michal
