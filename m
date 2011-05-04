Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304505628-21965-1-git-send-email-lkslawek@gmail.com>
References: <1304505628-21965-1-git-send-email-lkslawek@gmail.com>
Date: Wed, 4 May 2011 12:53:11 +0200
Message-ID: <BANLkTin=cCSu_L4GmFSKLpP_+tojGc3nAA@mail.gmail.com>
Subject: Re: [PATCH] Add partial mas.c - messages-*.c API.
From: Daniele Forsi <dforsi@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/5/4 Slawomir Bochenski:

> diff --git a/plugins/messages.h b/plugins/messages.h

> + * ordered by PARAMETERMASK. Boolean values should be probably
> + * always send (need checking). Handle is mandatory. Plugin will filter out any

nitpicking: s/send/sent/

> + * If session start succeeded, backend shall return 0. Otherwise the error value
> + * will be send as a response to OBEX connect.

s/send/sent/

-- 
Daniele Forsi
