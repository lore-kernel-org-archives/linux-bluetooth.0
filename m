Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH BlueZ 3/3] core: Rename hcid.h to main.h
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362140773-13672-3-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 1 Mar 2013 08:15:16 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <68C3A27C-6218-4DCA-BC3A-D6813E3F9EFC@holtmann.org>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com> <1362140773-13672-3-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


> main seems more logical than hcid which use to be the binary name of
> bluetoothd really long time ago.
> ---
> Makefile.am                   | 2 +-
> plugins/gatt-example.c        | 2 +-
> plugins/neard.c               | 2 +-
> profiles/proximity/main.c     | 2 +-
> profiles/proximity/reporter.c | 2 +-
> src/adapter.c                 | 2 +-
> src/attrib-server.c           | 2 +-
> src/device.c                  | 2 +-
> src/main.c                    | 2 +-
> src/{hcid.h => main.h}        | 0
> src/plugin.c                  | 2 +-
> src/profile.c                 | 2 +-
> src/rfkill.c                  | 2 +-
> src/sdpd-server.c             | 2 +-
> src/sdpd-service.c            | 2 +-
> 15 files changed, 14 insertions(+), 14 deletions(-)
> rename src/{hcid.h => main.h} (100%)

NAK. main.h is one single header we are not going to have. I do not want main.c to share anything actually. I want main.c to consume everything else.

Regards

Marcel

