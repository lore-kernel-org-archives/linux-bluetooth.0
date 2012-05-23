Return-Path: <cyrus@holtmann.org>
Message-ID: <1337779699.15105.79.camel@aeonflux>
Subject: Re: [PATCH 00/11] gdbus: Better D-Bus introspection
From: Marcel Holtmann <marcel@holtmann.org>
To: Henrique Dante de Almeida <hdante@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 May 2012 15:28:19 +0200
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrique,

> Introspection patches to neard
> 
> Henrique Dante de Almeida (4):
>   Constify GDBus method tables
>   Constify GDBus signal tables
>   Convert GDBus methods and signals to use macro helpers
>   Do not set signature and reply in GDBus tables
> 
> Lucas De Marchi (7):
>   gdbus: add argument info to methods and signals
>   gdbus: add and use helpers for table declarations
>   gdbus: use GDBusArgInfo to generate introspection
>   gdbus: loop over args to check message signature
>   gdbus: remove signature and reply from tables
>   gdbus: add Deprecated annotation in introspection
>   gdbus: add Method.NoReply annotation in introspection
> 
>  gdbus/gdbus.h  |   47 +++++++++++++++++++-
>  gdbus/object.c |  132 +++++++++++++++++++++++++++-----------------------------
>  src/adapter.c  |   23 ++++++----
>  src/device.c   |   19 +++++---
>  src/manager.c  |   19 +++++---
>  src/ndef.c     |    6 ++-
>  src/tag.c      |   18 +++++---
>  7 files changed, 163 insertions(+), 101 deletions(-)

wrong mailing list, but I applied all 11 patches now.

Regards

Marcel


