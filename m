Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E398C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 05:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiDAF7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 01:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiDAF7E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 01:59:04 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1201258FEC
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 22:57:13 -0700 (PDT)
X-QQ-mid: bizesmtp83t1648792627tlsq9jzf
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Apr 2022 13:57:02 +0800 (CST)
X-QQ-SSF: 00400000000000D0D000B00A0000000
X-QQ-FEAT: 0VgNaGdhy9gd5d/sxpwtg5ZFowgjY5dX7h/ZW411sYk0FtwA7ADCuqGuSnkZS
        3hDkYvp4K/yCGCDl14knf/zLP/Qgyi7BWZ8C9s8usYt2WLbEyjbrkTugK7FYlXPQyLrKJHr
        XQHHW1ap2DADM1MADiN4VqM9W6N5XKW0FERduFMxeIoUVIb8r6kxcTu1b3QWoQNNXYogIIl
        3+iWzH0HrLvmDrxh2nGVL94wLvu6xmHkmgeLIr2YIiJYyYlhpcVxRwuLOxKCD95tGYhZiP+
        DxUf6hrVsSExu+HYMSSaJVGRSCZpR+tGJlj4z/X7JlPS0ex7ZNoMSfNh0qEsMxkulLICEQ/
        sjzZ7Y5g7o1OiyMRXf8E/GJPkLiJSWqIWnbtbcJ
X-QQ-GoodBg: 2
From:   xinpeng wang <wangxinpeng@uniontech.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: Re: [PATCH v4] obexd: Fix can't receive small files sent by windows
Date:   Fri,  1 Apr 2022 13:56:42 +0800
Message-Id: <20220401055642.16343-1-wangxinpeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CABBYNZKDdRLEk7NEHoZ_uJV2cUNm9qHuWvaiqDotWpSL=LnLQg@mail.gmail.com>
References: <CABBYNZKDdRLEk7NEHoZ_uJV2cUNm9qHuWvaiqDotWpSL=LnLQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Xinpeng Wang <wangxinpeng@uniontech.com>

Hi, Luiz,
  Thank you for your reply. I just started to study BlueZ. After receiving 
your reply, I reread the code and tested it again with Ubuntu.

On 30 3月 22 13:56:57, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Mar 28, 2022 at 11:02 PM xinpeng wang <wangxinpeng@uniontech.com> wrote:
> >
> > When obexd receives a file, it parses the filename and other parameters
> > when processing the packet for the first time, store filename in
> > obex_session and emit the dbus signal, The signal will be pending first.
> > then when this file is received, transfer_complete reset obex_session
> > is called.
> 
> So if I understand you correctly the problem is that Status does
> transit directly to complete and end up swallowing the active state?
> That is not necessarily a bug since the file would still be saved.

First of all, I think this is really a bug. Transfer small file from a 
Windows 10 computer to a Linux computer with a graphical interface via 
Bluetooth. After the transfer, the file cannot be found in the ~/Downloads 
directory of the Linux computer, but the Linux computer has a prompt that 
the file is in the ~/Downloads directory.

> 
> > When using a computer with Windows 10 installed to send a file to bluez,
> > obexd will read the data through read_stream; if it is a small file, the
> > data processed for the first time is marked as final, and
> > transfer_complete reset obex_session will be called when the data is
> > processed for the first time. At this point, the dbus signal is still
> > pending, and the dbus method that requests the file path has not been
> > processed. This will cause the upper application to not be able to
> > transfer files from the cache directory to the directory specified by
> > the user.
> 
> This doesn't sound right, we have chk_put callback that calls into
> manager_request_authorization and that blocks untils the
> agent->auth_pending responds, so it sounds like the agent is not
> responding in time or windows is using ftp instead of opp? Well ftp

Windows uses opp, add use AuthorizePush.

> doesn't even use AuthorizePush, I'm also confused about the mention of
> a cache directory and user specified directory, there are no such
> things there only the root directory option which is used as default
> location and AuthorizePush can opt to store in a different location if

The cache directory is "~/Cache/obexd". In my test, Authorizepush always 
returns this directory; The user specified directory refers to the 
directory specified by the user on the graphical interface, for example, 
in ubuntu, Setting - Bluetooth, there will be a prompt "transferred files 
are placed in the XXXX folder", default is "~/Downloads", You can change it 
to another directory here. obexd stores the received files in the cached 
directory, and after transfer completed, the upper-level program mv files 
to user specified directory.

> necessary, but the transfer doesn't start until the agent reply
> AuthorizePush or at least that what the code assumes with:
> 
> /* Workaround: process events while agent doesn't reply */
> while (agent && agent->auth_pending)
> g_main_context_iteration(NULL, TRUE);
> 

I first debug this problem on UOS(a linux distribution), the upper-level 
application starts to request the filename after receiving the active 
signal, so there must be this problem.

In ubuntu, first of all i found that it is very difficult to transfer 
files from windows to ubuntu, because AuthorizePush always returns 
forbidden directly. After installed blueman, it is possible to transfer 
files.

I found that ubuntu calls the dbus method to request the name after 
cmd_connect, so that the session->name, that is, the filename, is obtained 
in the place you mentioned above, and there is no path. But in my test, 
ubuntu does not mv the small file to the ~/Downloads directory in most cases, 
and it will be fine after applying my patch. I don't understand the 
upper-level program of ubuntu. I suspect it is related to the active signal?

> > To solve this problem, emit Filename's dbus signal and force it when
> > status=active.
> >
> > Ways to reproduce the problem:
> > 1. Use the computer with windows 10 installed to send a small file to
> > the computer with ubuntu installed;
> > 2. file size < 10k;
> > 3. After sending, in most cases, the file is located in the
> > ~/.cache/obexd/ directory. Normally, the file should be located in the
> > ~/Download directory.
> 
> Is ~/.cache/obexd its passed as -r/--root to obexd? Could it be that
> the agent doesn't respond for some reason? e.g. the transfer status is
> not active?
>

"~/.cache/obexd" and agent are normal.
 
> > To fix this, after applying this commit, it also needs to be modified by
> > the upper-level application. Modified to read Filename from dbus signal
> > if there is Filename in dbus signal. Otherwise, use the dbus method to
> > request Filename.
> 
> The method is used to accept the request, so something else is broken
> if the file ends up being accepted before the user is able to accept
> it, also it is probably a security breach if small files can bypass
> the user authorization.
> 

This patch won't have the security issues you mentioned, because the added 
signals are all after AuthorizePush returns successfully. My test is that 
before AuthorizePush returns or returns fail, no signal will be emitted and 
file transfer will not start. 

The method is used to request the file name and path. What I mean here is 
that for the upper-level program, if there is a Filename in the dbus signal, 
use this value, otherwise, call the dbus method to get it as before. In ubuntu
(without this patch), the file name is obtained before AuthorizePush returns. 

> > ---
> > v4: fix COMMIT_LOG_LONG_LINE error of checkpatch
> >
> >  obexd/src/manager.c | 6 +++++-
> >  obexd/src/obex.c    | 1 +
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> > index 01741fe62..2c180dc44 100644
> > --- a/obexd/src/manager.c
> > +++ b/obexd/src/manager.c
> > @@ -533,8 +533,12 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
> >  void manager_emit_transfer_started(struct obex_transfer *transfer)
> >  {
> >         transfer->status = TRANSFER_STATUS_ACTIVE;
> > +       if (!transfer->path)
> > +               return;
> >
> > -       manager_emit_transfer_property(transfer, "Status");
> > +       g_dbus_emit_property_changed_full(connection, transfer->path,
> > +                                       TRANSFER_INTERFACE, "Status",
> > +                                       G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
> >  }
> >
> >  static void emit_transfer_completed(struct obex_transfer *transfer,
> > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> > index 3a68fd66c..c0d9e160a 100644
> > --- a/obexd/src/obex.c
> > +++ b/obexd/src/obex.c
> > @@ -720,6 +720,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
> >                 manager_emit_transfer_property(os->service_data, "Size");
> >
> >         os->path = g_strdup(filename);
> > +       manager_emit_transfer_property(os->service_data, "Filename");
> >
> >         return 0;
> >  }
> > --
> > 2.20.1
> >
> >
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
> 


