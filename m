Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/4] Move common client code to bt_shell
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170921174021.20154-1-marcin.kraglak@tieto.com>
Date: Thu, 21 Sep 2017 20:36:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CB8FC172-FF24-4B34-8279-01022CBF864E@holtmann.org>
References: <20170921174021.20154-1-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> This is first part of moving common code of client and meshctl to shared
> directory. Next steps would be:
> - functions for switching between menus (needed for meshctl)
> - display functions
> - common support for history
> 
> Marcin Kraglak (4):
>  shared/shell/bt_shell: Add initial implementation
>  client: Use bt_shell to process commands.
>  shared/shell/bt_shell: Add bt_shell_completion
>  client: Use bt_shell_completion
> 
> Makefile.tools              |   3 +-
> client/main.c               |  93 ++-------------------------
> src/shared/shell/bt_shell.c | 152 ++++++++++++++++++++++++++++++++++++++++++++
> src/shared/shell/bt_shell.h |  43 +++++++++++++

I am not a big fan of this deep directory structure. So either src/shell/ or put it all src/shared/. However I am sure tab-completion will be a pain with src/shell and src/shared ;)

Regards

Marcel

