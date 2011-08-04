Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312465504-26373-1-git-send-email-lkslawek@gmail.com>
References: <1312465504-26373-1-git-send-email-lkslawek@gmail.com>
Date: Thu, 4 Aug 2011 18:09:59 +0300
Message-ID: <CABBYNZL9RYyeqAGZXEUSRaY-M4f=M9-m3k3mbZh4-ff-0PiyPQ@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] Simplify symbolic links support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 4, 2011 at 4:45 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> This patch changes the way the symbolic links are treated by FTP, making code a
> bit simpler and FTP more intuitive.
>
> Previously symlinks were supposed to be disallowed unless the -l option was
> used, and with that option, only symlinks present directly inside root folder
> were followed. This did not work for file links, as fstat() check on open()-ed
> won't result in S_IFLNK set, so symbolic links to files were followed
> regardless to options.
>
> Now links inside root folder are always allowed. Without -l (--symlinks)
> option, following them is only allowed when the resulting real path is still
> inside the given root directory. When -l is given, all symlinks are followed.

This only resolves the security problem of following the symbolic
links, but what we do with the clients not being able to see it is a
link since it is not part of the folder listing, this can be
inconsistent since the user can try to remove the file, which is what
we will be stating, but end up removing only the link (see remove
manpage), in the other hand if we remove both the user still have no
clue that other files maybe affected.

-- 
Luiz Augusto von Dentz
