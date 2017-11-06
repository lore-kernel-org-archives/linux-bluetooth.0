Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170922050002.24002-1-marcin.kraglak@tieto.com>
References: <20170922050002.24002-1-marcin.kraglak@tieto.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Nov 2017 14:34:55 +0200
Message-ID: <CABBYNZ+vs22rahzjfevxkiR_ubCQ=_DAh+HBvZ220u2WsTGPJw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Move common client code to bt_shell
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Sep 22, 2017 at 7:59 AM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> This is first part of moving common code of client and meshctl to shared
> directory. Next steps would be:
>  - functions for switching between menus (needed for meshctl)
>  - display functions
>  - common support for history
>
>
> Marcin Kraglak (4):
>   shared/bt_shell: Add initial implementation
>   client: Use bt_shell to process commands.
>   shared/bt_shell: Add bt_shell_completion
>   client: Use bt_shell_completion
>
>  Makefile.tools        |   3 +-
>  client/main.c         |  93 +++---------------------------
>  src/shared/bt_shell.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/bt_shell.h |  43 ++++++++++++++
>  4 files changed, 204 insertions(+), 87 deletions(-)
>  create mode 100644 src/shared/bt_shell.c
>  create mode 100644 src/shared/bt_shell.h
>
> --
> 2.13.5

Would you be able to continue working on this?

-- 
Luiz Augusto von Dentz
